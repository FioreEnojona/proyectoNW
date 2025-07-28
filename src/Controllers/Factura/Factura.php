<?php

namespace Controllers\Factura;

use Controllers\PublicController;
use Dao\Factura\Factura as FacturaDAO;
use Views\Renderer;

class Factura extends PublicController
{
    public function run(): void
    {
        $factura = FacturaDAO::obtenerFacturaPorId("5O190127TN364715T");

        Renderer::render("factura/factura", [
            "id" => $factura["id"],
            "status" => $factura["status"],
            "intent" => $factura["intent"],
            "create_time" => $factura["create_time"],
            "nombre" => $factura["payer"]["name"]["given_name"] . " " . $factura["payer"]["name"]["surname"],
            "email" => $factura["payer"]["email_address"],
            "payer_id" => $factura["payer"]["payer_id"],
            "referencia" => $factura["purchase_units"][0]["reference_id"],
            "moneda" => $factura["purchase_units"][0]["amount"]["currency_code"],
            "total" => $factura["purchase_units"][0]["amount"]["value"]
        ]);
    }
}
