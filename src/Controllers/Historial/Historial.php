<?php

namespace Controllers\Historial;

use Controllers\PrivateController;
use Controllers\PublicController;
use Views\Renderer;
use Dao\Bitacora\Bitacora as BitacoraDao;

class Historial extends PublicController
{
    public function run(): void
    {
        $bitacoras = BitacoraDao::obtenerBitacorasPorUsuario($_SESSION["login"]["userId"]);

        Renderer::render("historial/historial", [
            "bitacoras" => $bitacoras
        ]);
    }
}
