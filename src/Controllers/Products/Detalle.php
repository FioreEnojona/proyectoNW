<?php

namespace Controllers\Products;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Products\Products as ProductsDao;
use Utilities\Site;

class Detalle extends PublicController
{
    private $viewData = [];
    private $producto = [];

    public function run(): void
    {
        try {
            $this->getData();
            $this->setViewData();
            Renderer::render("products/detalle", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Products_Products",
                $ex->getMessage()
            );
        }
    }

    private function getData(): void
    {
        $productId = intval($_GET["productId"] ?? 0);
        if ($productId <= 0) {
            throw new \Exception("ID de producto inválido.");
        }

        $producto = ProductsDao::getProductById($productId);
        if (!$producto) {
            throw new \Exception("Producto no encontrado.");
        }

        $this->producto = $producto;
    }

    private function setViewData(): void
    {
        // Escapar valores
        foreach ($this->producto as $key => $value) {
            $this->producto[$key] = htmlspecialchars(strval($value));
        }

        $this->viewData["FormTitle"] = sprintf(
            "Detalle de Producto: %s",
            $this->producto["productName"]
        );

        $this->viewData["product"] = $this->producto;
        $this->viewData["showCommitBtn"] = false; // Solo lectura
        $this->viewData["readonly"] = "readonly";
    }
}
