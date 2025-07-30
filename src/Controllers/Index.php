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
        Site::addLink("public/css/style.css");

        // Obtener categorías
        $viewData = [];
        $viewData["categories"] = CategoriasDao::getCategorias();
        $categoriaId = isset($_GET["categoriaId"]) ? intval($_GET["categoriaId"]) : 0;
        $viewData["selected_categoriaId"] = $categoriaId;

        // Obtener productos filtrados por categoría
        $productos = ProductsDao::getProducts("", "ACT", "productName", false, 0, 1000, $categoriaId);
        $viewData["products"] = $productos["products"];

        // Manejar POST (añadir al carrito)
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

        // Búsqueda por nombre (si aplica)
        $nombre = $_GET["nombre"] ?? "";
        if (!empty($nombre)) {
            $viewData["products"] = Cart::buscarPorNombre($nombre);
        }

        // Renderizar vista con todos los datos
        Renderer::render("index", $viewData);
    }
}
