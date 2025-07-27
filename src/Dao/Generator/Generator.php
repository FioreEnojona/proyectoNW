<?php

namespace Dao\Generator;

use Dao\Table;

class Generator extends Table
{
    public static function getDescription(String $tableName)
    {
        $sql = "DESCRIBE $tableName";
        return self::obtenerRegistros($sql, []);
    }

    public static function getTables()
    {
        $sql = "SHOW TABLES";
        $result = self::obtenerRegistros($sql, []);

        // Convertir a formato estándar: ['name' => 'nombre_tabla']
        $tables = [];
        foreach ($result as $row) {
            $tables[] = ['name' => array_values($row)[0]];
        }

        return $tables;
    }
}
