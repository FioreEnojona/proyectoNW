<?php

namespace Dao\Bitacora;

use Dao\Table;

class Bitacora extends Table
{
    public static function getByUserAndType($bitusuario, $bitTipo)
    {
        return self::obtenerRegistros(
            "SELECT * FROM bitacora WHERE bitusuario = :bitusuario AND bitTipo = :bitTipo ORDER BY bitacorafch DESC;",
            [
                "bitusuario" => $bitusuario,
                "bitTipo" => $bitTipo
            ]
        );
    }
}
