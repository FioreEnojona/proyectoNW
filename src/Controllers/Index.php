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
use Dao\Products\Products as ProductsDao;
use Dao\Products\Categorias as CategoriasDao;
use Utilities\Site;
use Utilities\Cart\CartFns;
use Utilities\Security;
use Views\Renderer;

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

        // Manejo de operaciones del carrito
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

        // Obtener parámetros de filtrado
        $nombre = $_GET["nombre"] ?? "";
        $categoriaId = isset($_GET["categoriaId"]) ? intval($_GET["categoriaId"]) : 0;

        // Obtener productos según filtros
        if (!empty($nombre)) {
            $products = Cart::buscarPorNombre($nombre);
            $viewData["products"] = $products;
        } else {
            $productos = ProductsDao::getProducts("", "ACT", "productName", false, 0, 1000, $categoriaId);
            $viewData["allProducts"] = $productos["products"];
        }

        // Obtener categorías para el filtro
        $resultadoCategorias = CategoriasDao::getCategorias();
        $categorias = $resultadoCategorias["categorias"];

        foreach ($categorias as $cat) {
            $viewData["categories"][] = [
                "categoriaId" => $cat["id"],
                "nombre" => $cat["nombre"],
                "selected_categoriaId" => ($cat["id"] == $categoriaId) ? "selected" : ""
            ];
        }

        // Datos adicionales para la vista
        $viewData["selected_categoriaId"] = $categoriaId;
        $viewData["searchTerm"] = $nombre;

        Renderer::render("index", $viewData);
    }
}
