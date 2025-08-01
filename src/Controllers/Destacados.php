<?php

namespace Controllers;

use \Dao\Products\Products as ProductsDao;
use \Views\Renderer as Renderer;
use \Utilities\Site as Site;


class Destacados extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/products.css");
        Site::addLink("public/css/style.css");
        $viewData = [];
        $viewData["productsOnSale"] = ProductsDao::getDailyDeals();
        $viewData["productsNew"] = ProductsDao::getNewProducts();
        Renderer::render("destacados", $viewData);
    }
}
