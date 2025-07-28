<?php

namespace Controllers\Historial;

use Controllers\PublicController;
use Dao\Factura\Factura as FacturaDAO;
use Views\Renderer;

class Historial extends PublicController
{
    public function run(): void
    {
        $facturas = FacturaDAO::obtenerFacturaPorId("5O190127TN364715T");

        Renderer::render("historial/historial", [
            "id" => $facturas["id"],
            "status" => $facturas["status"],
            "intent" => $facturas["intent"],
            "create_time" => $facturas["create_time"],
            "nombre" => $facturas["payer"]["name"]["given_name"] . " " . $facturas["payer"]["name"]["surname"],
            "email" => $facturas["payer"]["email_address"],
            "payer_id" => $facturas["payer"]["payer_id"],
            "referencia" => $facturas["purchase_units"][0]["reference_id"],
            "moneda" => $facturas["purchase_units"][0]["amount"]["currency_code"],
            "total" => $facturas["purchase_units"][0]["amount"]["value"]
        ]);
    }
}
