<?php

/**
 * PHP Version 7.2
 *
 * @category Public
 * @package  Controllers
 * @author   Orlando J Betancourth <orlando.betancourth@gmail.com>
 * @license  MIT http://
 * @version  CVS:1.0.0
 * @link     http://
 */

namespace Controllers;

use Dao\Cart\Cart;
use Utilities\Site;
use Utilities\Cart\CartFns;
use Utilities\Security;
use Dao\Products\Products as ProductsDao;
use Dao\Products\Categorias as CategoriasDao;

/**
 * Index Controller
 *
 * @category Public
 * @package  Controllers
 * @author   Orlando J Betancourth <orlando.betancourth@gmail.com>
 * @license  MIT http://
 * @link     http://
 */
class Index extends PublicController
{
    /**
     * Index run method
     *
     * @return void
     */
    public function run(): void
    {
        Site::addLink("public/css/products.css");
        Site::addLink("public/css/style.css");

        $viewData = [];

        $categoriaId = isset($_GET["categoriaId"]) ? intval($_GET["categoriaId"]) : 0;
        $viewData["selected_categoriaId"] = $categoriaId;

        $productos = ProductsDao::getProducts("", "ACT", "productName", false, 0, 1000, $categoriaId);
        $viewData["allProducts"] = $productos["products"];

        $resultadoCategorias = CategoriasDao::getCategorias();
        $categorias = $resultadoCategorias["categorias"];

        foreach ($categorias as $cat) {
            $viewData["categories"][] = [
                "categoriaId" => $cat["id"],
                "nombre" => $cat["nombre"],
                "selected_categoriaId" => ($cat["id"] == $categoriaId) ? "selected" : ""
            ];
        }


        if ($this->isPostBack()) {
            if (Security::isLogged()) {
                $usercod = Security::getUserId();
                $productId = intval($_POST["productId"]);
                $product = Cart::getProductoDisponible($productId);

                if ($product && isset($product["productStock"]) && $product["productStock"] - 1 >= 0) {
                    Cart::addToAuthCart(
                        $productId,
                        $usercod,
                        1,
                        $product["productPrice"]
                    );
                }
            } else {
                $cartAnonCod = CartFns::getAnnonCartCode();
                if (isset($_POST["addToCart"])) {
                    $productId = intval($_POST["productId"]);
                    $product = Cart::getProductoDisponible($productId);

                    if ($product && isset($product["productStock"]) && $product["productStock"] - 1 >= 0) {
                        Cart::addToAnonCart(
                            $productId,
                            $cartAnonCod,
                            1,
                            $product["productPrice"]
                        );
                    }
                }
            }
            $this->getCartCounter();
        }

        $nombre = $_GET["nombre"] ?? "";
        if (!empty($nombre)) {
            $products = Cart::buscarPorNombre($nombre);
        } else {
            $products = Cart::getProductosDisponibles();
        }




        $viewData = [
            "products" => $products,
        ];
        \Views\Renderer::render("index", $viewData);
    }
}
