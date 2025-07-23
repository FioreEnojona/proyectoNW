<?php

namespace Controllers\Seguridad;

use Controllers\PublicController;
use Dao\Seguridad\Roles as RolesDAO;
use Views\Renderer;

class Roles extends PublicController
{
    private array $viewData;

    public function __construct()
    {
        $this->viewData = [
            "roles" => []
        ];
    }

    public function run(): void
    {
        $this->viewData["roles"] = RolesDAO::getRol();
        Renderer::render("seguridad/roles", $this->viewData);
    }
}
