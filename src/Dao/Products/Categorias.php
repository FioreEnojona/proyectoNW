<?php

namespace Dao\Products;

use Dao\Table;

class Categorias extends Table
{

    public static function getCategorias(
        string $partialName = "",
        string $status = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ): array {
        $sqlstr = "SELECT id, nombre, estado FROM categorias";
        $sqlstrCount = "SELECT COUNT(*) as count FROM categorias";

        $conditions = [];
        $params = [];

        if ($partialName !== "") {
            $conditions[] = "nombre LIKE :partialName";
            $params["partialName"] = "%" . $partialName . "%";
        }

        if (!in_array($status, ["ACT", "INA", "RTR", ""])) {
            throw new \Exception("Estado inválido");
        }

        if ($status !== "") {
            $conditions[] = "estado = :estado";
            $params["estado"] = $status;
        }

        if (count($conditions) > 0) {
            $sqlWhere = " WHERE " . implode(" AND ", $conditions);
            $sqlstr .= $sqlWhere;
            $sqlstrCount .= $sqlWhere;
        }

        if (!in_array($orderBy, ["id", "nombre", "estado", ""])) {
            throw new \Exception("Orden inválido");
        }

        if ($orderBy !== "") {
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
            "categorias" => $registros,
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

    public static function getCateoriasById(int $categoriaId)
    {
        $sqlstr = "SELECT * from categorias where id = :id;";
        return self::obtenerUnRegistro($sqlstr, ["id" => $categoriaId]);
    }
    public static function nuevaCategoria(string $nombre, string $estado)
    {
        $sqlstr = "INSERT INTO categorias (nombre, estado) VALUES (:nombre, :estado);";
        return self::executeNonQuery(
            $sqlstr,
            [
                "nombre" => $nombre,
                "estado" => $estado
            ]
        );
    }

    public static function actualizarCategoria(int $id, string $nombre, string $estado): int
    {
        $sqlstr = "UPDATE categorias set nombre = :nombre, estado = :estado where id = :id;";

        return self::executeNonQuery(
            $sqlstr,
            [
                "nombre" => $nombre,
                "estado" => $estado,
                "id" => $id
            ]
        );
    }

    public static function eliminarCategoria(int $id): int
    {
        $sqlstr = "DELETE from categorias where id = :id;";
        return self::executeNonQuery(
            $sqlstr,
            [
                "id" => $id
            ]
        );
    }
}
