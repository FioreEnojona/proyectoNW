<?php

namespace Controllers\Mantenimientos\Productos;

use Controllers\PrivateController;
use Dao\Products\Categorias as CategoriasDAO;
use Views\Renderer;

class Categorias extends PrivateController
{
    private array $viewData;
    public function __construct()
    {
        $this->viewData = [
            "categorias" => []
        ];
    }
    public function run(): void
    {
        $this->viewData["categorias"] = CategoriasDAO::getCategorias();
        Renderer::render("mnt/productos/categorias", $this->viewData);
    }
}
