<?php

namespace Controllers\Seguridad;

use Controllers\PublicController;
use Dao\Seguridad\Roles as RolesDAO;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

const LIST_URL = "index.php?page=Seguridad-Roles";
const XSR_KEY = "xsrToken_roles";

class Rol extends PublicController
{
    private array $viewData;
    private array $modes;
    private array $estados;


    public function __construct()
    {
        $this->modes = [
            "INS" => 'Creando nuevo rol',
            "UPD" => 'Modificando rol %s %s',
            "DEL" => 'Eliminando rol %s %s',
            "DSP" => 'Mostrando detalle de %s %s'
        ];
        $this->estados = ["ACT", "INA", "RTR"];

        $this->viewData = [
            "rolescod" => 0,
            "rolesest" => "",
            "rolesdsc" => "",
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
        Renderer::render("seguridad/rol", $this->viewData);
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
            if (isset($_GET["rolescod"])) {
                $this->viewData["rolescod"] = $_GET["rolescod"];
                $rol = RolesDAO::getRolById($this->viewData["rolescod"]);
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
        $this->viewData["rolescod"] = $_POST["rolescod"] ?? $this->viewData["rolescod"];
        $this->viewData["rolesdsc"] = $_POST["rolesdsc"] ?? $this->viewData["rolesdsc"];
        $this->viewData["rolesest"] = $_POST["rolesest"] ?? $this->viewData["rolesest"];
        $this->viewData["xsrToken"] = $_POST["xsrToken"] ?? $this->viewData["xsrToken"];
    }

    private function throwError(string $message)
    {
        Site::redirectToWithMsg(LIST_URL, $message);
    }

    private function validarDatos()
    {
        if (Validators::IsEmpty($this->viewData["rolesdsc"])) {
            $this->viewData["errores"]["rolesdsc"] = "Campo necesario";
        }

        if (!in_array($this->viewData["rolesest"], $this->estados)) {
            $this->viewData["errores"]["rolesest"] = "El valor del estado no es correcto";
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
                    RolesDAO::nuevoRol(
                        $this->viewData["rolesdsc"],
                        $this->viewData["rolesest"]
                    ) > 0
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Rol agregado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al crear nuevo rol."];
                }
                break;
            case "UPD":
                if (
                    RolesDAO::actualizarRol(
                        $this->viewData["rolescod"],
                        $this->viewData["rolesdsc"],
                        $this->viewData["rolesest"]
                    )
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Rol actualizado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al actualizar el rol."];
                }
                break;
            case "DEL":
                if (
                    RolesDAO::eliminarRol($this->viewData["rolescod"])
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Rol eliminado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al eliminar el rol."];
                }
                break;
        }
    }

    private function prepararVista()
    {
        $this->viewData["modeDsc"] = sprintf(
            $this->modes[$this->viewData["mode"]],
            $this->viewData["rolesest"],
            $this->viewData["rolescod"]
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

        $this->viewData["xsrToken"] = hash("sha256", random_int(0, 1000000) . time() . 'rol' . $this->viewData["mode"]);
        $_SESSION[XSR_KEY] = $this->viewData["xsrToken"];
    }
}
