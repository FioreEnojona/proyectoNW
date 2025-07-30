<?php

namespace Controllers\Sec;

use Views\Renderer;

class Valores extends \Controllers\PublicController
{
    public function run(): void
    {

        $viewData = [];
        Renderer::render("security/valores", $viewData);
    }
}
