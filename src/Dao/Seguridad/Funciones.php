<?php

namespace Dao\Seguridad;

use Dao\Table;

class Funciones extends Table
{
    public static function getFunciones()
    {
        $sqlstr = "SELECT * FROM funciones;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getFuncionesById(string $fncod)
    {
        $sqlstr = "SELECT * FROM funciones WHERE fncod = :fncod;";
        return self::obtenerUnRegistro($sqlstr, ["fncod" => $fncod]);
    }

    public static function nuevoFunciones(
        string $fndsc,
        string $fnest,
        string $fntyp

    ) {
        $sqlstr = "INSERT INTO funciones (fndsc, fnest, fntyp) 
            VALUES (:fndsc, :fnest, :fntyp);";

        return self::executeNonQuery(
            $sqlstr,
            [
                "fndsc" => $fndsc,
                "fnest" => $fnest,
                "fntyp" => $fntyp
            ]
        );
    }

    public static function actualizarFunciones(
        string $fncod,
        string $fndsc,
        string $fnest,
        string $fntyp
    ) {
        $sqlstr = "UPDATE funciones SET 
            fndsc = :fndsc,
            fnest = :fnest,
            fntyp = :fntyp
            WHERE fncod = :fncod;";

        return self::executeNonQuery(
            $sqlstr,
            [
                "fndsc" => $fndsc,
                "fnest" => $fnest,
                "fncod" => $fncod,
                "fntyp" => $fntyp
            ]
        );
    }



    public static function getFuncionesCount(): int
    {
        $sqlstr = "SELECT COUNT(*) as total FROM funciones;";
        $result = self::obtenerUnRegistro($sqlstr, []);
        return intval($result["total"]);
    }

    public static function eliminarFunciones(string $fncod)
    {
        $sqlstr = "DELETE FROM funciones WHERE fncod = :fncod;";
        return self::executeNonQuery($sqlstr, ["fncod" => $fncod]);
    }
}
