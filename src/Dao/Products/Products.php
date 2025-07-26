<?php

namespace Dao\Products;

use Dao\Table;

class Products extends Table
{
    public static function getFeaturedProducts()
    {
        $sqlstr = "SELECT p.productId, p.productName, p.productDescription, p.productPrice, p.productImgUrl, p.productStatus,
                          c.nombre as categoriaNombre
                   FROM products p 
                   INNER JOIN highlights h ON p.productId = h.productId 
                   INNER JOIN categorias c ON p.categoriaId = c.id
                   WHERE h.highlightStart <= NOW() AND h.highlightEnd >= NOW()";
        $params = [];
        return self::obtenerRegistros($sqlstr, $params);
    }

    public static function getNewProducts()
    {
        $sqlstr = "SELECT p.productId, p.productName, p.productDescription, p.productPrice, p.productImgUrl, p.productStatus,
                          c.nombre as categoriaNombre
                   FROM products p 
                   INNER JOIN categorias c ON p.categoriaId = c.id
                   WHERE p.productStatus = 'ACT' 
                   ORDER BY p.productId DESC 
                   LIMIT 3";
        $params = [];
        return self::obtenerRegistros($sqlstr, $params);
    }

    public static function getProducts(
        string $partialName = "",
        string $status = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10,
        int $categoriaId = 0
    ) {
        $sqlstr = "SELECT p.productId, p.productName, p.productDescription, p.productPrice, p.productImgUrl, p.productStatus,
                          c.nombre as categoriaNombre,
                          CASE 
                              WHEN p.productStatus = 'ACT' THEN 'Activo' 
                              WHEN p.productStatus = 'INA' THEN 'Inactivo' 
                              ELSE 'Sin Asignar' 
                          END as productStatusDsc 
                   FROM products p
                   INNER JOIN categorias c ON p.categoriaId = c.id";

        $sqlstrCount = "SELECT COUNT(*) as count FROM products p INNER JOIN categorias c ON p.categoriaId = c.id";

        $conditions = [];
        $params = [];

        if ($partialName != "") {
            $conditions[] = "p.productName LIKE :partialName";
            $params["partialName"] = "%" . $partialName . "%";
        }

        if (!in_array($status, ["ACT", "INA", ""])) {
            throw new \Exception("Error Processing Request: Status has invalid value");
        }

        if ($status != "") {
            $conditions[] = "p.productStatus = :status";
            $params["status"] = $status;
        }

        if ($categoriaId > 0) {
            $conditions[] = "p.categoriaId = :categoriaId";
            $params["categoriaId"] = $categoriaId;
        }

        if (count($conditions) > 0) {
            $sqlWhere = " WHERE " . implode(" AND ", $conditions);
            $sqlstr .= $sqlWhere;
            $sqlstrCount .= $sqlWhere;
        }

        if (!in_array($orderBy, ["productId", "productName", "productPrice", ""])) {
            throw new \Exception("Error Processing Request: OrderBy has invalid value");
        }

        if ($orderBy != "") {
            $sqlstr .= " ORDER BY " . $orderBy;
            if ($orderDescending) {
                $sqlstr .= " DESC";
            }
        }

        $numeroDeRegistros = self::obtenerUnRegistro($sqlstrCount, $params)["count"];

        list($page, $itemsPerPage) = self::sanitizePagination($page, $itemsPerPage, $numeroDeRegistros);

        $sqlstr .= " LIMIT " . ($page * $itemsPerPage) . ", " . $itemsPerPage;

        $registros = self::obtenerRegistros($sqlstr, $params);
        return [
            "products" => $registros,
            "total" => $numeroDeRegistros,
            "page" => $page,
            "itemsPerPage" => $itemsPerPage
        ];
    }

    private static function sanitizePagination(int $page, int $itemsPerPage, int $totalItems): array
    {
        $page = max(0, $page);
        $itemsPerPage = max(1, $itemsPerPage);
        $pagesCount = ceil($totalItems / $itemsPerPage);
        if ($page > $pagesCount - 1) {
            $page = max(0, $pagesCount - 1);
        }
        return [$page, $itemsPerPage];
    }

    public static function getProductById(int $productId)
    {
        $sqlstr = "SELECT p.productId, p.productName, p.productDescription, p.productPrice, p.productImgUrl, p.productStatus,
                          c.id as categoriaId, c.nombre as categoriaNombre
                   FROM products p 
                   INNER JOIN categorias c ON p.categoriaId = c.id
                   WHERE p.productId = :productId";
        $params = ["productId" => $productId];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertProduct(
        string $productName,
        string $productDescription,
        float $productPrice,
        string $productImgUrl,
        string $productStatus,
        int $categoriaId
    ) {
        $sqlstr = "INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStatus, categoriaId) 
                   VALUES (:productName, :productDescription, :productPrice, :productImgUrl, :productStatus, :categoriaId)";
        $params = [
            "productName" => $productName,
            "productDescription" => $productDescription,
            "productPrice" => $productPrice,
            "productImgUrl" => $productImgUrl,
            "productStatus" => $productStatus,
            "categoriaId" => $categoriaId
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function updateProduct(
        int $productId,
        string $productName,
        string $productDescription,
        float $productPrice,
        string $productImgUrl,
        string $productStatus,
        int $categoriaId
    ) {
        $sqlstr = "UPDATE products 
                   SET productName = :productName, productDescription = :productDescription, 
                       productPrice = :productPrice, productImgUrl = :productImgUrl, 
                       productStatus = :productStatus, categoriaId = :categoriaId
                   WHERE productId = :productId";
        $params = [
            "productId" => $productId,
            "productName" => $productName,
            "productDescription" => $productDescription,
            "productPrice" => $productPrice,
            "productImgUrl" => $productImgUrl,
            "productStatus" => $productStatus,
            "categoriaId" => $categoriaId
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteProduct(int $productId)
    {
        $sqlstr = "DELETE FROM products WHERE productId = :productId";
        $params = ["productId" => $productId];
        return self::executeNonQuery($sqlstr, $params);
    }
}
