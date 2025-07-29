<?php

namespace Dao\Seguridad;

use Dao\Table;

class Usuarios extends Table
{
    public static function getUsuarios()
    {
        $sqlstr = "SELECT * FROM usuario;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getUsuarioById(int $id)
    {
        $sqlstr = "SELECT * FROM usuario WHERE usercod = :id;";
        return self::obtenerUnRegistro($sqlstr, ["id" => $id]);
    }

    public static function nuevoUsuario(
        string $useremail,
        string $username,
        string $userpswd,
        string $userfching,
        string $userpswdest,
        string $userpswdexp,
        string $userest,
        string $useractcod,
        string $userpswdchg,
        string $usertipo
    ) {
        $sqlstr = "INSERT INTO usuario (useremail, username, userpswd, userfching, userpswdest, userpswdexp, userest, useractcod, userpswdchg, usertipo) 
            VALUES (:useremail, :username, :userpswd, :userfching, :userpswdest, :userpswdexp, :userest, :useractcod, :userpswdchg, :usertipo);";

        return self::executeNonQuery(
            $sqlstr,
            [
                "useremail" => $useremail,
                "username" => $username,
                "userpswd" => $userpswd,
                "userfching" => $userfching,
                "userpswdest" => $userpswdest,
                "userpswdexp" => $userpswdexp,
                "userest" => $userest,
                "useractcod" => $useractcod,
                "userpswdchg" => $userpswdchg,
                "usertipo" => $usertipo
            ]
        );
    }

    public static function actualizarUsuario(
        int $id,
        string $useremail,
        string $username,
        string $userpswd,
        string $userfching,
        string $userpswdest,
        string $userpswdexp,
        string $userest,
        string $useractcod,
        string $userpswdchg,
        string $usertipo
    ) {
        $sqlstr = "UPDATE usuario SET 
            useremail = :useremail,
            username = :username,
            userpswd = :userpswd,
            userfching = :userfching,
            userpswdest = :userpswdest,
            userpswdexp = :userpswdexp,
            userest = :userest,
            useractcod = :useractcod,
            userpswdchg = :userpswdchg,
            usertipo = :usertipo
            WHERE usercod = :id;";

        return self::executeNonQuery(
            $sqlstr,
            [
                "useremail" => $useremail,
                "username" => $username,
                "userpswd" => $userpswd,
                "userfching" => $userfching,
                "userpswdest" => $userpswdest,
                "userpswdexp" => $userpswdexp,
                "userest" => $userest,
                "useractcod" => $useractcod,
                "userpswdchg" => $userpswdchg,
                "usertipo" => $usertipo,
                "id" => $id
            ]
        );
    }

    public static function eliminarUsuario(int $id)
    {
        $sqlstr = "DELETE FROM usuario WHERE usercod = :id;";
        return self::executeNonQuery($sqlstr, ["id" => $id]);
    }
}
