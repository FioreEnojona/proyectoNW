<?php

namespace Dao\Products;

use Dao\Table;

class Products extends Table
{
    public static function getFeaturedProducts()
    {
        $sqlstr = "SELECT 
                p.productId, 
                p.productName, 
                p.productDescription, 
                p.productPrice, 
                p.productImgUrl, 
                p.productStatus,
                p.productStock
              FROM products p 
              INNER JOIN highlights h ON p.productId = h.productId 
              WHERE p.productStatus = 'ACT'
              AND h.highlightStart <= CURRENT_DATE() 
              AND h.highlightEnd >= CURRENT_DATE()";
        $params = [];
        return self::obtenerRegistros($sqlstr, $params);
    }

    public static function getNewProducts()
    {
        $sqlstr = "SELECT 
                p.productId, 
                p.productName, 
                p.productDescription, 
                p.productPrice, 
                p.productImgUrl, 
                p.productStatus,
                p.productStock
                FROM products p 
                WHERE p.productStatus = 'ACT' 
                ORDER BY p.productId DESC 
                LIMIT 3";
        $params = [];
        return self::obtenerRegistros($sqlstr, $params);
    }

    public static function getDailyDeals()
    {
        $sqlstr = "SELECT 
                p.productId, 
                p.productName, 
                p.productDescription, 
                s.salePrice as productPrice, 
                p.productImgUrl, 
                p.productStatus,
                p.productStock
              FROM products p 
              INNER JOIN sales s ON p.productId = s.productId 
              WHERE p.productStatus = 'ACT'
              AND s.saleStart <= CURRENT_DATE() 
              AND s.saleEnd >= CURRENT_DATE()";
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
        $sqlstr = "SELECT 
                 p.productId, 
                 p.productName, 
                 p.productDescription, 
                 p.productPrice, 
                 p.productImgUrl, 
                 p.productStatus,
                 p.productStock,
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
        $sqlstr = "SELECT 
                p.productId, 
                p.productName, 
                p.productDescription, 
                p.productPrice, 
                p.productImgUrl, 
                p.productStatus,
                p.productStock,
                p.categoriaId,
                p.productIngredients,
                p.productFeatures,
                p.productPresentation,
                p.productAllergens,
                p.productRecommendation,
                p.productStorage,
                p.productCustom,
                c.nombre as categoriaNombre
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
        string $categoriaId,
        int $productStock = 0
    ): int {
        $sqlstr = "INSERT INTO products 
                  (productName, productDescription, productPrice, productImgUrl, 
                   productStatus, categoriaId, productStock) 
                  VALUES 
                  (:productName, :productDescription, :productPrice, :productImgUrl, 
                   :productStatus, :categoriaId, :productStock)";
        return self::executeNonQuery($sqlstr, [
            "productName" => $productName,
            "productDescription" => $productDescription,
            "productPrice" => $productPrice,
            "productImgUrl" => $productImgUrl,
            "productStatus" => $productStatus,
            "categoriaId" => $categoriaId,
            "productStock" => $productStock
        ]);
    }

    public static function updateProduct(
        int $productId,
        string $productName,
        string $productDescription,
        float $productPrice,
        string $productImgUrl,
        string $productStatus,
        string $categoriaId,
        int $productStock
    ): int {
        $sqlstr = "UPDATE products SET 
                  productName = :productName,
                  productDescription = :productDescription,
                  productPrice = :productPrice,
                  productImgUrl = :productImgUrl,
                  productStatus = :productStatus,
                  categoriaId = :categoriaId,
                  productStock = :productStock
                  WHERE productId = :productId";
        return self::executeNonQuery($sqlstr, [
            "productId" => $productId,
            "productName" => $productName,
            "productDescription" => $productDescription,
            "productPrice" => $productPrice,
            "productImgUrl" => $productImgUrl,
            "productStatus" => $productStatus,
            "categoriaId" => $categoriaId,
            "productStock" => $productStock
        ]);
    }

    public static function deleteProduct(int $productId)
    {
        $sqlstr = "DELETE FROM products WHERE productId = :productId";
        $params = ["productId" => $productId];
        return self::executeNonQuery($sqlstr, $params);
    }
}
