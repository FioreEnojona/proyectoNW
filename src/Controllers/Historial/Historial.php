<?php

namespace Controllers\Historial;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Bitacora\Bitacora as BitacoraDao;
use \Utilities\Site as Site;

class Historial extends PrivateController
{
    public function run(): void
    {
        $bitacoras = BitacoraDao::obtenerBitacorasPorUsuario($_SESSION["login"]["userId"]);

        Renderer::render("historial/historial", [
            "bitacoras" => $bitacoras
        ]);
    }
}
