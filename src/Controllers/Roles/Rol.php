<?php

namespace Controllers\Roles;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Roles\Roles as RolesDao;
use Utilities\Site;
use Utilities\Validators;

const LIST_URL = "index.php?page=Roles-Roles-Roles";
const XSR_KEY = "xsrToken_roles";

class Rol extends PrivateController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle de %s %s",
        "INS" => "Nuevo Rol",
        "UPD" => "Editar %s %s",
        "DEL" => "Eliminar %s %s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $role = [
        "rolescod" => "",
        "rolesdsc" => "",
        "rolesest" => "ACT"
    ];
    private $role_xss_token = "";

    public function run(): void
    {
        try {
            $this->getData();
            if ($this->isPostBack()) {
                if ($this->validateData()) {
                    $this->handlePostAction();
                }
            }
            $this->setViewData();
            Renderer::render("roles/rol", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Roles_Roles",
                $ex->getMessage()
            );
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";

        if (isset($this->modeDescriptions[$this->mode])) {
            if (!$this->isFeatureAutorized("role_" . $this->mode)) {
                throw new \Exception("No tiene permisos para realizar esta acción.", 1);
            }

            $this->readonly = $this->mode === "DEL" ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";

            if ($this->mode !== "INS") {
                $roleCode = $_GET["rolescod"] ?? null;
                if (is_null($roleCode)) {
                    throw new \Exception("No se proporcionó un código de rol válido", 1);
                }

                $this->role = RolesDao::getRoleByCode($roleCode);
                if (!$this->role) {
                    throw new \Exception("No se encontró el Rol", 1);
                }
            }
        } else {
            throw new \Exception("Formulario cargado en modalidad inválida", 1);
        }
    }

    private function validateData()
    {
        if ($this->mode === "DEL") {
            $this->role["rolescod"] = strval($_POST["rolescod"] ?? "");
            return !empty($this->role["rolescod"]);
        }

        $errors = [];
        $this->role_xss_token = $_POST["role_xss_token"] ?? "";

        $this->role["rolescod"] = strval($_POST["rolescod"] ?? "");
        $this->role["rolesdsc"] = strval($_POST["rolesdsc"] ?? "");
        $this->role["rolesest"] = strval($_POST["rolesest"] ?? "");

        if (Validators::IsEmpty($this->role["rolescod"])) {
            $errors["rolescod_error"] = "El código del rol es requerido";
        }

        if (Validators::IsEmpty($this->role["rolesdsc"])) {
            $errors["rolesdsc_error"] = "La descripción del rol es requerida";
        }

        if (!in_array($this->role["rolesest"], ["ACT", "INA"])) {
            $errors["rolesest_error"] = "El estado del rol es inválido";
        }

        if (count($errors) > 0) {
            foreach ($errors as $key => $value) {
                $this->role[$key] = $value;
            }
            return false;
        }

        return true;
    }

    private function handlePostAction()
    {
        switch ($this->mode) {
            case "INS":
                $this->handleInsert();
                break;
            case "UPD":
                $this->handleUpdate();
                break;
            case "DEL":
                $this->handleDelete();
                break;
            default:
                throw new \Exception("Modo inválido", 1);
        }
    }

    private function handleInsert()
    {
        $result = RolesDao::insertRole(
            $this->role["rolescod"],
            $this->role["rolesdsc"],
            $this->role["rolesest"]
        );
        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Roles_Roles",
                "Rol creado exitosamente"
            );
        } else {
            $this->viewData["error"] = "Error al insertar el rol";
        }
    }

    private function handleUpdate()
    {
        $result = RolesDao::updateRole(
            $this->role["rolescod"],
            $this->role["rolesdsc"],
            $this->role["rolesest"]
        );
        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Roles_Roles",
                "Rol actualizado exitosamente"
            );
        } else {
            $this->viewData["error"] = "Error al actualizar el rol";
        }
    }

    private function handleDelete()
    {
        $result = RolesDao::deleteRole($this->role["rolescod"]);
        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Roles_Roles",
                "Rol eliminado exitosamente"
            );
        } else {
            $this->viewData["error"] = "Error al eliminar el rol";
        }
    }

    private function setViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["role_xss_token"] = $this->role_xss_token;
        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->role["rolescod"],
            $this->role["rolesdsc"]
        );
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["readonly"] = $this->readonly;

        $this->role["roleStatusDsc"] = ($this->role["rolesest"] == "ACT") ? "Activo" : "Inactivo";
        $this->viewData["rolesStatus_act"] = ($this->role["rolesest"] == "ACT") ? "selected" : "";
        $this->viewData["rolesStatus_ina"] = ($this->role["rolesest"] == "INA") ? "selected" : "";

        $this->viewData["role"] = $this->role;
    }
}
