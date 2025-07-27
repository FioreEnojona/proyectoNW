<?php

namespace Controllers\Generator;

use Controllers\PublicController;
use Views\Renderer;


class Generator extends PublicController
{

    public function run(): void
    {

        $viewData["tables"] = \Dao\Generator\Generator::getTables();
        if ($this->isPostBack()) {
            $table = $_POST["table"] ?? '';

            if (!empty($table)) {
                $viewData["columns"] = \Dao\Generator\Generator::getDescription($table);
                $gen = new GeneratorHelper($viewData["columns"], $table);
                $viewData["genResult"] = $gen->getDaoPhpCode();
                $viewData["genController"] = $gen->getControllerPhpCode();
                $viewData["genSimpleController"] = $gen->getSimpleControllerPhpCode();
                $viewData["genForm"] = $gen->getFormTemplateCode();
                $viewData["genList"] = $gen->getListTemplateCode();
            } else {
                $viewData["error"] = "Debe seleccionar una tabla para generar el código.";
            }
        }

        Renderer::render("generator/generator", $viewData);
    }
}
