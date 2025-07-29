<?php

namespace Dao\Bitacora;

use Dao\Table;

class bitClient extends Table
{
    public static function obtenerBitacoraIndividual($id)
    {
        $sqlStr = "SELECT * from bitacora where bitusuario = :bitusuario;";
        return self::obtenerRegistros($sqlStr, array("bitusuario" => intval($id)));
    }
}
