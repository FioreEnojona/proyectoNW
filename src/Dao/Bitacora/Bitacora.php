<?php

namespace Dao\Bitacora;

use Dao\Table;

class Bitacora extends Table
{
    public static function obtenerBitacoras()
    {
        $sqlStr = "SELECT * from bitacora;";
        return self::obtenerRegistros($sqlStr, array());
    }
    public static function obtenerBitacora($bitacoracod)
    {
        $sqlStr = "SELECT * from bitacora where bitacoracod = :bitacoracod;";
        return self::obtenerUnRegistro($sqlStr, array("bitacoracod" => intval($bitacoracod)));
    }
    public static function guardarCompra($bitprograma, $bitdescripcion, $bitTotal, $bitSubtotal, $bitusuarioId, $bitTipo)
    {
        $sqlStr = "INSERT INTO bitacora (
            bitacorafch,
            bitprograma,
            bitdescripcion,
            bitobservacion,
            bitTipo,
            bitusuario
          ) VALUES (
            NOW(),
            :bitprograma,
            :bitdescripcion,
            CONCAT('Total: ', :bitTotal, ', Subtotal: ', :bitSubtotal),
            :bitTipo,
            :bitusuario
          )";

        $parametros = array(
            "bitprograma" => $bitprograma,
            "bitdescripcion" => $bitdescripcion,
            "bitTotal" => $bitTotal,
            "bitSubtotal" => $bitSubtotal,
            "bitusuario" => $bitusuarioId,
            "bitTipo" => $bitTipo
        );

        return self::executeNonQuery($sqlStr, $parametros);
    }
    public static function obtenerBitacorasPorUsuario($userId)
    {
        $sqlStr = "SELECT b.*, u.userName
               FROM bitacora b
               INNER JOIN usuario u ON b.bitusuario = u.usercod
               WHERE b.bitusuario = :userid
               ORDER BY b.bitacorafch DESC;";
        return self::obtenerRegistros($sqlStr, ["userid" => $userId]);
    }
}
