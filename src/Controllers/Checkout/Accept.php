<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\Cart\Cart;
use Utilities\Security;


class Accept extends PublicController
{
    public function run(): void
    {
        $dataview = [];
        $token = $_GET["token"] ?? "";
        $session_token = $_SESSION["orderid"] ?? "";

        if ($token !== "" && $token == $session_token) {
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);

            $ordenProductos = \Dao\Cart\Cart::getAuthCart($_SESSION["login"]["userId"]);

            if (!empty($ordenProductos)) {
                foreach ($ordenProductos as $producto) {
                    \Dao\Bitacora\Bitacora::guardarCompra(
                        $producto["productName"],
                        "Orden Aceptada",
                        $producto["crrctd"] * $producto["crrprc"],
                        $producto["crrctd"] * $producto["crrprc"],
                        $_SESSION["login"]["userId"],
                        "ACP"
                    );
                    \Dao\Cart\Cart::restarStock($producto["productId"], $producto["crrctd"]);
                }
                \Dao\Cart\Cart::clearAuthCart($_SESSION["login"]["userId"]);
            }

            $factura = [
                "id_transaccion" => $result->id ?? "SIN ID",
                "estado"         => $result->status ?? "SIN ESTADO",
                "fecha"          => $result->purchase_units[0]->payments->captures[0]->create_time ?? date("Y-m-d H:i:s"),
                "comprador"      => (($result->payer->name->given_name ?? "") . " " . ($result->payer->name->surname ?? "")),
                "email"          => $result->payer->email_address ?? "No disponible",
                "productos"      => [],
                "total"          => 0
            ];

            $total = 0;
            foreach ($ordenProductos as $prod) {
                $subtotal = $prod["crrprc"] * $prod["crrctd"];
                $factura["productos"][] = [
                    "nombre"   => $prod["productName"],
                    "cantidad" => $prod["crrctd"],
                    "precio"   => number_format($prod["crrprc"], 2),
                    "subtotal" => number_format($subtotal, 2)
                ];
                $total += $subtotal;
            }
            $factura["total"] = number_format($total, 2);

            // 🔹 Enviar cada campo como variable independiente a la vista
            $dataview = [
                "id_transaccion" => $factura["id_transaccion"],
                "estado"         => $factura["estado"],
                "fecha"          => $factura["fecha"],
                "comprador"      => $factura["comprador"],
                "email"          => $factura["email"],
                "productos"      => $factura["productos"],
                "total"          => $factura["total"]
            ];
        } else {
            $dataview["error"] = "No Order Available!!!";
        }

        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
