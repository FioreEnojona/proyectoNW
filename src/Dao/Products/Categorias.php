<?php

namespace Dao\Products;

use Dao\Table;

class Categorias extends Table
{

    public static function getCategorias()
    {
        $sqlstr = "SELECT * from categorias;";
        return self::obtenerRegistros($sqlstr, []);
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
