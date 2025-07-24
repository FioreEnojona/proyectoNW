<?php

namespace Controllers\Seguridad;

use Controllers\PublicController;
use Dao\Seguridad\Funciones as FuncionesDAO;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

const LIST_URL = "index.php?page=Seguridad-Funciones";
const XSR_KEY = "xsrToken_funciones";

class Funcion extends PublicController
{
    private array $viewData;
    private array $modes;
    private array $estados;


    public function __construct()
    {
        $this->modes = [
            "INS" => 'Creando nueva funcion',
            "UPD" => 'Modificando funcion %s %s',
            "DEL" => 'Eliminando funcion %s %s',
            "DSP" => 'Mostrando detalle de %s %s'
        ];
        $this->estados = ["ACT", "INA", "RTR"];

        $this->viewData = [
            "fncod" => "",
            "fndsc" => "",
            "fnest" => "",
            "fntyp" => "",
            "estadoACT" => "",
            "estadoINA" => "",
            "estadoRTR" => "",
            "errores" => [],
            "readonly" => "",
            "showAction" => true,
            "xsrToken" => ""
        ];
    }

    public function run(): void
    {
        $this->capturarModoPantalla();
        $this->datosDeDao();
        if ($this->isPostBack()) {
            $this->datosFormulario();
            $this->validarDatos();
            if (count($this->viewData["errores"]) === 0) {
                $this->procesarDatos();
            }
        }

        $this->prepararVista();
        Renderer::render("seguridad/funcion", $this->viewData);
    }

    private function capturarModoPantalla()
    {
        if (isset($_GET["mode"])) {
            $this->viewData["mode"] = $_GET["mode"];
            if (!isset($this->modes[$this->viewData["mode"]])) {
                $this->throwError("BAD REQUEST: No se puede procesar su solicitud.");
            }
        }
    }

    private function datosDeDao()
    {
        if ($this->viewData["mode"] != "INS") {
            if (isset($_GET["fncod"])) {
                $this->viewData["fncod"] = $_GET["fncod"];
                $rol = FuncionesDAO::getFuncionesById($this->viewData["fncod"]);
                if (count($rol) > 0) {
                    $this->viewData = array_merge($this->viewData, $rol);
                } else {
                    $this->throwError("BAD REQUEST: No existe registro en la DB");
                }
            } else {
                $this->throwError("BAD REQUEST: No se puede extraer el registro de la DB");
            }
        }
    }

    private function datosFormulario()
    {
        $this->viewData["fncod"] = $_POST["fncod"] ?? $this->viewData["fncod"];
        $this->viewData["fndsc"] = $_POST["fndsc"] ?? $this->viewData["fndsc"];
        $this->viewData["fnest"] = $_POST["fnest"] ?? $this->viewData["fnest"];
        $this->viewData["fntyp"] = $_POST["fntyp"] ?? $this->viewData["fntyp"];
        $this->viewData["xsrToken"] = $_POST["xsrToken"] ?? $this->viewData["xsrToken"];
    }



    private function throwError(string $message)
    {
        Site::redirectToWithMsg(LIST_URL, $message);
    }

    private function validarDatos()
    {
        if (Validators::IsEmpty($this->viewData["fndsc"])) {
            $this->viewData["errores"]["fndsc"] = "Campo necesario";
        }

        if (Validators::IsEmpty($this->viewData["fnest"], $this->estados)) {
            $this->viewData["errores"]["fnest"] = "Estado invalido";
        }

        if (Validators::IsEmpty($this->viewData["fntyp"])) {
            $this->viewData["errores"]["fntyp"] = "Campo invalido";
        }
        $tmpXsrToken = $_SESSION[XSR_KEY] ?? '';
        if ($this->viewData["xsrToken"] !== $tmpXsrToken) {
            error_log("Token inválido.");
            $this->throwError("Solicitud inválida. Intente de nuevo.");
        }
    }
    private function procesarDatos()
    {
        switch ($this->viewData["mode"]) {
            case "INS":
                if (
                    FuncionesDAO::nuevoFunciones(
                        $this->viewData["fndsc"],
                        $this->viewData["fnest"],
                        $this->viewData["fntyp"]

                    ) > 0
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Funcion agregada exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al crear nueva funcion."];
                }
                break;
            case "UPD":
                if (
                    FuncionesDAO::actualizarFunciones(
                        $this->viewData["fncod"],
                        $this->viewData["fndsc"],
                        $this->viewData["fnest"],
                        $this->viewData["fntyp"]

                    )
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Funcion actualizado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al actualizar el funcion."];
                }
                break;
            case "DEL":
                if (
                    FuncionesDAO::eliminarFunciones($this->viewData["fncod"])
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Funcion eliminada exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al eliminar el funcion."];
                }
                break;
        }
    }

    private function prepararVista()
    {
        $this->viewData["modeDsc"] = sprintf(
            $this->modes[$this->viewData["mode"]],
            $this->viewData["fnest"],
            $this->viewData["fncod"]
        );

        if (count($this->viewData["errores"]) > 0) {
            foreach ($this->viewData["errores"] as $campo => $error) {
                $this->viewData['error_' . $campo] = $error;
            }
        }

        if ($this->viewData["mode"] === "DEL" ||  $this->viewData["mode"] === "DSP") {
            $this->viewData["readonly"] = "readonly";
        }
        if ($this->viewData["mode"] === "DSP") {
            $this->viewData["showAction"] = false;
        }

        $this->viewData["xsrToken"] = hash("sha256", random_int(0, 1000000) . time() . 'funcion' . $this->viewData["mode"]);
        $_SESSION[XSR_KEY] = $this->viewData["xsrToken"];
    }
}
