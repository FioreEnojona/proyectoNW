<?php

namespace Controllers;

use \Dao\Products\Products as ProductsDao;
use \Dao\Products\Categorias as CategoriasDao;
use \Views\Renderer as Renderer;
use \Utilities\Site as Site;

class Index extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/products.css");
        $viewData = [];

        $categoriaId = isset($_GET["categoriaId"]) ? intval($_GET["categoriaId"]) : 0;
        $viewData["selected_categoriaId"] = $categoriaId;

        $productos = ProductsDao::getProducts(
            "",
            "ACT",
            "productName",
            false,
            0,
            1000,
            $categoriaId
        );
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


        Renderer::render("index", $viewData);
    }
}
