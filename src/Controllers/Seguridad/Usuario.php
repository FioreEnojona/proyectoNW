<?php

namespace Controllers\Seguridad;

use Controllers\PublicController;
use Dao\Seguridad\Usuarios as UsuariosDAO;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

const LIST_URL = "index.php?page=Seguridad-Usuarios";
const XSR_KEY = "xsrToken_usuarios";

class Usuario extends PublicController
{
    private array $viewData;
    private array $estados;
    private array $modes;

    public function __construct()
    {
        $this->modes = [
            "INS" => 'Creando nuevo usuario',
            "UPD" => 'Modificando usuario %s %s',
            "DEL" => 'Eliminando usuario %s %s',
            "DSP" => 'Mostrando detalle de %s %s'
        ];
        $this->estados = ["ACT", "INA", "RTR"];
        $this->viewData = [
            "id" => 0,
            "useremail" => "",
            "username" => "",
            "userpswd" => "",
            "userfching" => "",
            "userpswdest" => "ACT",
            "userpswdexp" => "",
            "userest" => "ACT",
            "useractcod" => "",
            "userpswdchg" => "",
            "usertipo" => "",
            "mode" => "",
            "modeDsc" => "",
            "estadoACT" => "",
            "estadoINA" => "",
            "estadoRTR" => "",
            "pswdestACT" => "",
            "pswdestINA" => "",
            "pswdestEXP" => "",
            "tipoNOR" => "",
            "tipoCON" => "",
            "tipoCLI" => "",
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
        Renderer::render("seguridad/usuario", $this->viewData);
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
            if (isset($_GET["id"])) {
                $this->viewData["id"] = intval($_GET["id"]);
                $usuario = UsuariosDAO::getUsuarioById($this->viewData["id"]);
                if (count($usuario) > 0) {
                    $this->viewData = array_merge($this->viewData, $usuario);
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
        $this->viewData["id"] = $_POST["usercod"] ?? $this->viewData["id"];
        $this->viewData["useremail"] = $_POST["useremail"] ?? $this->viewData["useremail"];
        $this->viewData["username"] = $_POST["username"] ?? $this->viewData["username"];
        $this->viewData["userpswd"] = $_POST["userpswd"] ?? $this->viewData["userpswd"];
        $this->viewData["userfching"] = $_POST["userfching"] ?? $this->viewData["userfching"];
        $this->viewData["userpswdest"] = $_POST["userpswdest"] ?? $this->viewData["userpswdest"];
        $this->viewData["userpswdexp"] = $_POST["userpswdexp"] ?? null;
        $this->viewData["userest"] = $_POST["userest"] ?? $this->viewData["userest"];
        $this->viewData["useractcod"] = $_POST["useractcod"] ?? $this->viewData["useractcod"];
        $this->viewData["userpswdchg"] = $_POST["userpswdchg"] ?? null;
        $this->viewData["usertipo"] = $_POST["usertipo"] ?? $this->viewData["usertipo"];
        $this->viewData["xsrToken"] = $_POST["xsrToken"] ?? $this->viewData["xsrToken"];
    }

    private function throwError(string $message)
    {
        Site::redirectToWithMsg(LIST_URL, $message);
    }

    private function validarDatos()
    {
        if (Validators::IsEmpty($this->viewData["useremail"])) {
            $this->viewData["errores"]["useremail"] = "Correo requerido";
        } elseif (!Validators::IsValidEmail($this->viewData["useremail"])) {
            $this->viewData["errores"]["useremail"] = "Correo inválido";
        }

        if (Validators::IsEmpty($this->viewData["username"])) {
            $this->viewData["errores"]["username"] = "Nombre requerido";
        }

        if (Validators::IsEmpty($this->viewData["userpswd"])) {
            $this->viewData["errores"]["userpswd"] = "Contraseña requerida";
        } elseif (strlen($this->viewData["userpswd"]) < 8) {
            $this->viewData["errores"]["userpswd"] = "Contraseña muy corta";
        }

        if (!in_array($this->viewData["userpswdest"], $this->estados)) {
            $this->viewData["errores"]["userpswdest"] = "Estado de contraseña inválido";
        }


        if (!in_array($this->viewData["userest"], ["ACT", "INA", "BLO"])) {
            $this->viewData["errores"]["userest"] = "Estado del usuario inválido";
        }

        if (Validators::IsEmpty($this->viewData["useractcod"])) {
            $this->viewData["errores"]["useractcod"] = "Código de activación requerido";
        }

        if (Validators::IsEmpty($this->viewData["userpswdchg"])) {
            $this->viewData["errores"]["userpswdchg"] = "Campo de cambio de contraseña requerido";
        }

        if (!in_array($this->viewData["usertipo"], ["NOR", "CON", "CLI"])) {
            $this->viewData["errores"]["usertipo"] = "Tipo de usuario inválido";
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
                    UsuariosDAO::nuevoUsuario(
                        $this->viewData["useremail"],
                        $this->viewData["username"],
                        $this->viewData["userpswd"],
                        $this->viewData["userfching"],
                        $this->viewData["userpswdest"],
                        $this->viewData["userpswdexp"],
                        $this->viewData["userest"],
                        $this->viewData["useractcod"],
                        $this->viewData["userpswdchg"],
                        $this->viewData["usertipo"]
                    ) > 0
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Usuario agregado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al crear nuevo usuario."];
                }
                break;
            case "UPD":
                if (
                    UsuariosDAO::actualizarUsuario(
                        $this->viewData["id"],
                        $this->viewData["useremail"],
                        $this->viewData["username"],
                        $this->viewData["userpswd"],
                        $this->viewData["userfching"],
                        $this->viewData["userpswdest"],
                        $this->viewData["userpswdexp"],
                        $this->viewData["userest"],
                        $this->viewData["useractcod"],
                        $this->viewData["userpswdchg"],
                        $this->viewData["usertipo"]
                    )
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Usuario actualizado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al actualizar el usuario."];
                }
                break;
            case "DEL":
                if (
                    UsuariosDAO::eliminarUsuario($this->viewData["id"])
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Usuario eliminado exitosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al eliminar el usuario."];
                }
                break;
        }
    }

    private function prepararVista()
    {
        $this->viewData["modeDsc"] = sprintf(
            $this->modes[$this->viewData["mode"]],
            $this->viewData["username"],
            $this->viewData["id"]
        );

        $this->viewData["estado" . $this->viewData["userest"]] = 'selected';
        $this->viewData["pswdest" . $this->viewData["userpswdest"]] = 'selected';
        $this->viewData["tipo" . $this->viewData["usertipo"]] = 'selected';

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

        $this->viewData["xsrToken"] = hash("sha256", random_int(0, 1000000) . time() . 'usuario' . $this->viewData["mode"]);
        $_SESSION[XSR_KEY] = $this->viewData["xsrToken"];
    }
}
