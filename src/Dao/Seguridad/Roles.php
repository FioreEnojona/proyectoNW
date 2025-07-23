<?php

namespace Dao\Seguridad;

use Dao\Table;

class Roles extends Table
{
    public static function getRol()
    {
        $sqlstr = "SELECT * FROM roles;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getRolById(string $rolescod)
    {
        $sqlstr = "SELECT * FROM roles WHERE rolescod = :rolescod;";
        return self::obtenerUnRegistro($sqlstr, ["rolescod" => $rolescod]);
    }

    public static function nuevoRol(
        string $rolesdsc,
        string $rolesest
    ) {
        $sqlstr = "INSERT INTO roles (rolesdsc, rolesest) 
            VALUES (:rolesdsc, :rolesest);";

        return self::executeNonQuery(
            $sqlstr,
            [
                "rolesdsc" => $rolesdsc,
                "rolesest" => $rolesest
            ]
        );
    }

    public static function actualizarRol(
        string $rolescod,
        string $rolesdsc,
        string $rolesest
    ) {
        $sqlstr = "UPDATE roles SET 
            rolesdsc = :rolesdsc,
            rolesest = :rolesest
            WHERE rolescod = :rolescod;";

        return self::executeNonQuery(
            $sqlstr,
            [
                "rolesdsc" => $rolesdsc,
                "rolesest" => $rolesest,
                "rolescod" => $rolescod
            ]
        );
    }

    public static function eliminarRol(string $rolescod)
    {
        $sqlstr = "DELETE FROM roles WHERE rolescod = :rolescod;";
        return self::executeNonQuery($sqlstr, ["rolescod" => $rolescod]);
    }
}
