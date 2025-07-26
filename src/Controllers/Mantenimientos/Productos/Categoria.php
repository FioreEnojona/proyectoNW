<?php

namespace Controllers\Mantenimientos\Productos;

use Controllers\PrivateController;
use Dao\Products\Categorias as CategoriasDAO;
use Error;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

const LIST_URL = "index.php?page=Mantenimientos-Productos-Categorias";
const XSR_KEY = "xsrToken_categorias";

class Categoria extends PrivateController
{
    private array $viewData;
    private array $estados;
    private array $modes;
    public function __construct()
    {
        $this->modes = [
            "INS" => 'Creando nueva Categoría',
            "UPD" => 'Modificando Categoría %s %s',
            "DEL" => 'Eliminado Categoría %s %s',
            "DSP" => 'Mostrando Detalle de %s %s'
        ];
        $this->estados = ["ACT", "INA", "RTR"];
        $this->viewData = [
            "id" => 0,
            "nombre" => "",
            "estado" => "ACT",
            "mode" => "",
            "modeDsc" => "",
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
        Renderer::render("mnt/productos/categoria", $this->viewData);
    }

    private function throwError(string $message)
    {
        Site::redirectToWithMsg(LIST_URL, $message);
    }
    private function capturarModoPantalla()
    {
        if (isset($_GET["mode"])) {
            $this->viewData["mode"] = $_GET["mode"];
            if (!isset($this->modes[$this->viewData["mode"]])) {
                $this->throwError("BAD REQUEST: No se puede procesar su solicitud.");
            }

            if (!$this->isFeatureAutorized("categorias_" . $this->viewData["mode"])) {
                $this->throwError("No tiene permiso para esta operación.");
            }
        }
    }

    private function datosDeDao()
    {
        if ($this->viewData["mode"] != "INS") {
            if (isset($_GET["id"])) {
                $this->viewData["id"] = intval($_GET["id"]);
                $categoria = CategoriasDAO::getCateoriasById($this->viewData["id"]);
                if (count($categoria) > 0) {
                    $this->viewData["nombre"] = $categoria["nombre"];
                    $this->viewData["estado"] = $categoria["estado"];
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
        if (isset($_POST["nombre"])) {
            $tmpNombre = $_POST["nombre"];
            $this->viewData["nombre"] = $tmpNombre;
        }
        if (isset($_POST["estado"])) {
            $tmpEstado = $_POST["estado"];
            $this->viewData["estado"] = $tmpEstado;
        }
        if (isset($_POST["xsrToken"])) {
            $tmpXsrToken = $_POST["xsrToken"];
            $this->viewData["xsrToken"] = $tmpXsrToken;
        }
    }
    private function validarDatos()
    {
        if (Validators::IsEmpty($this->viewData["nombre"])) {
            $this->viewData["errores"]["nombre"] = "Nombre es requerido";
        }
        if (!in_array($this->viewData["estado"], $this->estados)) {
            $this->viewData["errores"]["estado"] = "El valor del estado no es correcto";
        }
        $tmpXsrToken = $_SESSION[XSR_KEY];
        if ($this->viewData["xsrToken"] !== $tmpXsrToken) {
            error_log("Intento ingresar con un token inválido.");
            $this->throwError("Algo sucedió que impidio procesar la solicitud. Intente de nuevo!!");
        }
    }

    private function procesarDatos()
    {
        switch ($this->viewData["mode"]) {
            case "INS":
                if (
                    CategoriasDAO::nuevaCategoria(
                        $this->viewData["nombre"],
                        $this->viewData["estado"]
                    ) > 0
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Categoría agregada existosamente.");
                } else {
                    if (isset($this->viewData["errores"]["global"])) {
                        $this->viewData["errores"]["global"][] = "Error al crear nueva categoría.";
                    } else {
                        $this->viewData["errores"]["global"] = ["Error al crear nueva categoría."];
                    }
                }
                break;
            case "UPD":
                if (
                    CategoriasDAO::actualizarCategoria(
                        $this->viewData["id"],
                        $this->viewData["nombre"],
                        $this->viewData["estado"]
                    )
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Categoría actualizada existosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al actualizar la categoría."];
                }
                break;
            case "DEL":
                if (
                    CategoriasDAO::eliminarCategoria(
                        $this->viewData["id"]
                    )
                ) {
                    Site::redirectToWithMsg(LIST_URL, "Categoría eliminada existosamente.");
                } else {
                    $this->viewData["errores"]["global"] = ["Error al eliminar la categoría."];
                }
                break;
        }
    }
    private function prepararVista()
    {
        $this->viewData["modeDsc"] = sprintf(
            $this->modes[$this->viewData["mode"]],
            $this->viewData["nombre"],
            $this->viewData["id"]
        );
        $this->viewData["estado" . $this->viewData["estado"]] = 'selected';
        if (count($this->viewData["errores"]) > 0) {
            foreach ($this->viewData["errores"] as $campo => $error) {
                $this->viewData['error_' . $campo] = $error;
            }
        }
        // Elementos visuales
        if ($this->viewData["mode"] === "DEL" ||  $this->viewData["mode"] === "DSP") {
            $this->viewData["readonly"] = "readonly";
        }
        if ($this->viewData["mode"] === "DSP") {
            $this->viewData["showAction"] = false;
        }

        $this->viewData["xsrToken"] = hash("sha256", random_int(0, 1000000) . time() . 'categoria' . $this->viewData["mode"]);
        $_SESSION[XSR_KEY] = $this->viewData["xsrToken"];
    }
}
