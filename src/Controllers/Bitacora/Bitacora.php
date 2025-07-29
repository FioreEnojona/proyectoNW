<?php

namespace Controllers\Bitacora;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Bitacora\Bitacora as BitacoraDao;

class Bitacora extends PublicController
{
    public function run(): void
    {
        $userId = $_SESSION["userCode"] ?? 0;

        $bitacoraData = BitacoraDao::getByUserAndType($userId, 'CMP');

        Renderer::render("bitacora/historial", [
            "bitacoras" => $bitacoraData
        ]);
    }
}
