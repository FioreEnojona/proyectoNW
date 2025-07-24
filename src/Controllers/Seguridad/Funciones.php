<?php

namespace Controllers\Seguridad;

use Controllers\PublicController;
use Dao\Seguridad\Funciones as FuncionesDAO;
use Views\Renderer;

class Funciones extends PublicController
{
    private array $viewData;

    public function __construct()
    {
        $this->viewData = [
            "funciones" => []
        ];
    }

    public function run(): void
    {
        $this->viewData["funciones"] = FuncionesDAO::getFunciones();
        Renderer::render("seguridad/funciones", $this->viewData);
    }
}
