<?php

namespace Controllers;

use Dao\Cart\Cart;
use Dao\Products\Categorias as CategoriasDao;
use Utilities\Site;
use Utilities\Cart\CartFns;
use Utilities\Security;

/**
 * Index Controller
 */
class Index extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/products.css");

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

        // Parámetros de filtro
        $nombre = $_GET["nombre"] ?? "";
        $categoriaId = isset($_GET["categoriaId"]) ? intval($_GET["categoriaId"]) : 0;

        // Obtener productos según filtros
        if (!empty($nombre)) {
            // Si hay búsqueda por nombre, usa este método (filtra solo por nombre)
            $products = Cart::buscarPorNombre($nombre);
        } elseif ($categoriaId > 0) {
            // Si no hay nombre pero hay categoría, filtra por categoría
            $products = Cart::getByCategoria($categoriaId);
        } else {
            // Si no hay filtros, muestra todos los productos activos
            $products = Cart::getProductosDisponibles();
        }

        // Obtener categorías para filtro
        $resultadoCategorias = CategoriasDao::getCategorias();
        $categorias = $resultadoCategorias["categorias"] ?? [];

        $viewData = [
            "products" => $products,
            "categories" => [],
            "selected_categoriaId" => $categoriaId,
            "searchTerm" => $nombre,
        ];

        foreach ($categorias as $cat) {
            $viewData["categories"][] = [
                "categoriaId" => $cat["id"],
                "nombre" => $cat["nombre"],
                "selected_categoriaId" => ($cat["id"] == $categoriaId) ? "selected" : ""
            ];
        }

        \Views\Renderer::render("index", $viewData);
    }
}
