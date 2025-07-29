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
    public static function guardarCompra($bitprograma, $bitdescripcion, $bitTotal, $bitSubtotal, $bitusuario, $bitTipo, $bitImpuesto)
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
                CONCAT('Total: ', :bitTotal, ', Subtotal: ', :bitSubtotal, ', Impuesto: ', :bitImpuesto),
                :bitTipo,
                :bitusuario
              )";
        $parametros = array(
            "bitprograma" => $bitprograma,
            "bitdescripcion" => $bitdescripcion,
            "bitTotal" => $bitTotal,
            "bitSubtotal" => $bitSubtotal,
            "bitusuario" => $bitusuario,
            "bitImpuesto" => $bitImpuesto,
            "bitTipo" => $bitTipo
        );
        return self::executeNonQuery($sqlStr, $parametros);
    }
}
