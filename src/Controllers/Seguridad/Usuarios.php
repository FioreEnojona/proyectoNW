<?php

namespace Controllers\Seguridad;

use Controllers\PublicController;
use Dao\Seguridad\Usuarios as UsuariosDAO;
use Views\Renderer;

class Usuarios extends PublicController
{
    private array $viewData;

    public function __construct()
    {
        $this->viewData = [
            "usuarios" => []
        ];
    }

    public function run(): void
    {
        $this->viewData["usuarios"] = UsuariosDAO::getUsuarios();
        Renderer::render("seguridad/usuarios", $this->viewData);
    }
}
