<?php

namespace Dao\Historial;

use Dao\Table;

class Historial extends Table
{
    public static function obtenerTodasLasFacturas(): array
    {
        $facturas = [];

        $ordenesDir = __DIR__ . "/../../../../ordenes/";

        if (!is_dir($ordenesDir)) {
            error_log("Directorio no encontrado: " . $ordenesDir);
            return [];
        }

        $archivos = glob($ordenesDir . "order_*.json");
        error_log("Archivos encontrados: " . count($archivos));

        foreach ($archivos as $archivo) {
            $contenido = file_get_contents($archivo);
            $factura = json_decode($contenido, true);
            if ($factura && isset($factura["purchase_units"][0]["payments"]["captures"][0])) {
                $facturas[] = $factura;
            } else {
                error_log("Estructura inválida en archivo: " . $archivo);
            }
        }

        return $facturas;
    }
}
