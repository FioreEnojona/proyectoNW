<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Cart\CartFns;

class Checkout extends PublicController
{
    public function run(): void
    {
        $viewData = [
            "carretilla" => [],
            "carretillaAnon" => [],
            "total" => "0.00"
        ];

        // Determinar carrito según login
        if (Security::isLogged()) {
            $userId = Security::getUserId();
            $viewData["carretilla"] = Cart::getAuthCart($userId);

            // Mostrar también lo que haya en carretillaanon de esta sesión
            $anonCod = CartFns::getAnnonCartCode();
            $viewData["carretillaAnon"] = Cart::getAnonCart($anonCod);
        } else {
            $anonCod = CartFns::getAnnonCartCode();
            $viewData["carretilla"] = Cart::getAnonCart($anonCod);
        }

        // POST: Actualización de carrito o pago
        if ($this->isPostBack()) {
            $processPayment = true;

            if (empty($viewData["carretilla"])) {
                \Views\Renderer::render("paypal/noproducts", []);
                return;
            }
            if (!Security::isLogged()) {
                \Utilities\Site::redirectTo("index.php?page=Sec_Login");
                return;
            }
            // Botones + / -
            if (isset($_POST["removeOne"]) || isset($_POST["addOne"])) {
                $productId = intval($_POST["productId"]);
                $productoDisp = Cart::getProductoDisponible($productId);
                $amount = isset($_POST["removeOne"]) ? -1 : 1;

                if ($productoDisp && $productoDisp["productStock"] - $amount >= 0) {
                    if (Security::isLogged()) {
                        Cart::addToAuthCart($productId, $userId, $amount, $productoDisp["productPrice"]);
                    } else {
                        Cart::addToAnonCart($productId, $anonCod, $amount, $productoDisp["productPrice"]);
                    }
                }

                // Recargar carrito
                if (Security::isLogged()) {
                    $viewData["carretilla"] = Cart::getAuthCart($userId);
                    $viewData["carretillaAnon"] = Cart::getAnonCart($anonCod);
                } else {
                    $viewData["carretilla"] = Cart::getAnonCart($anonCod);
                }

                $processPayment = false;
            }

            // Procesar pago
            if ($processPayment) {
                $PayPalOrder = new \Utilities\Paypal\PayPalOrder(
                    "test" . (time() - 10000000),
                    "http://localhost:8080/proyectoNW/index.php?page=Checkout_Error",
                    "http://localhost:8080/proyectoNW/index.php?page=Checkout_Accept"
                );

                foreach ($viewData["carretilla"] as $producto) {
                    $PayPalOrder->addItem(
                        $producto["productName"],
                        $producto["productDescription"],
                        $producto["productId"],
                        $producto["crrprc"],
                        0,
                        $producto["crrctd"],
                        "DIGITAL_GOODS"
                    );
                }

                $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                    \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                    \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
                );
                $PayPalRestApi->getAccessToken();
                $response = $PayPalRestApi->createOrder($PayPalOrder);

                $_SESSION["orderid"] = $response->id;
                foreach ($response->links as $link) {
                    if ($link->rel == "approve") {
                        \Utilities\Site::redirectTo($link->href);
                    }
                }
                die();
            }
        }

        // Formatear carrito principal
        $finalCarretilla = [];
        $counter = 1;
        $total = 0;
        foreach ($viewData["carretilla"] as $prod) {
            $prod["row"] = $counter++;
            $prod["subtotal"] = number_format($prod["crrprc"] * $prod["crrctd"], 2);
            $total += $prod["crrprc"] * $prod["crrctd"];
            $prod["crrprc"] = number_format($prod["crrprc"], 2);
            $finalCarretilla[] = $prod;
        }

        // Formatear carrito anónimo extra (solo si está logueado)
        $finalCarretillaAnon = [];
        if (Security::isLogged()) {
            $counter = 1;
            foreach ($viewData["carretillaAnon"] as $prod) {
                $prod["row"] = $counter++;
                $prod["subtotal"] = number_format($prod["crrprc"] * $prod["crrctd"], 2);
                $prod["crrprc"] = number_format($prod["crrprc"], 2);
                $finalCarretillaAnon[] = $prod;
            }
        }

        $viewData["carretilla"] = $finalCarretilla;
        $viewData["carretillaAnon"] = $finalCarretillaAnon;
        $viewData["total"] = number_format($total, 2);

        \Views\Renderer::render("paypal/checkout", $viewData);
    }
}
