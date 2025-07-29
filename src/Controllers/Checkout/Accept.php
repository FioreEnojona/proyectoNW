<?php

namespace Controllers\Checkout;

use Controllers\PublicController;

class Accept extends PublicController
{
    public function run(): void
    {
        $dataview = array();
        $token = $_GET["token"] ?: "";
        $session_token = $_SESSION["orderid"] ?: "";
        if ($token !== "" && $token == $session_token) {
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);
            $dataview["orderjson"] = json_encode($result, JSON_PRETTY_PRINT);


            $ordenProductos = \Dao\Cart\Cart::getAuthCart($_SESSION["login"]["userId"]);

            if (!empty($ordenProductos)) {
                foreach ($ordenProductos as $producto) {
                    \Dao\Bitacora\Bitacora::guardarCompra(
                        $producto["productName"],                  // Nombre del producto
                        "Orden Aceptada",                           // Descripción
                        $producto["crrctd"] * $producto["crrprc"],  // Total
                        $producto["crrctd"] * $producto["crrprc"],  // Subtotal
                        $_SESSION["login"]["userId"],               // ID del usuario logueado
                        "ACP"                                       // Tipo
                    );
                }
            }
        } else {
            $dataview["orderjson"] = "No Order Available!!!";
        }


        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
