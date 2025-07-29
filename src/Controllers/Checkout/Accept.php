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


            $orden = \Dao\Cart\Cart::getAuthCart($_SESSION["login"]["userId"]);
            if (\Dao\Bitacora\Bitacora::guardarCompra(
                "Programa",
                "Orden Aceptada",
                $orden["ordenTotal"],
                $orden["ordenSubtotal"],
                $_SESSION["login"]["userId"],
                "ACP",
                $orden["ordenImpuestos"]
            )) {
            }
        } else {
            $dataview["orderjson"] = "No Order Available!!!";
        }

        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
