<?php

namespace Controllers\Seguridad;

use Controllers\PrivateController;
use Utilities\Context;
use Utilities\Paging;
use Dao\Seguridad\Usuarios as UsuariosDao;
use Views\Renderer;

class Usuarios extends PrivateController
{
    private $userEmail = "";
    private $userName = "";
    private $userStatus = "";
    private $orderBy = "";
    private $orderDescending = false;
    private $pageNumber = 1;
    private $itemsPerPage = 10;
    private $viewData = [];
    private $usuarios = [];
    private $usuariosCount = 0;
    private $pages = 0;
    private $user_DSP = false;
    private $user_UPD = false;
    private $user_DEL = false;
    private $user_INS = false;

    public function run(): void
    {
        $this->getParamsFromContext();
        $this->getParams();

        $tmpUsuarios = UsuariosDao::getUsuarios(); // Aquí puedes luego implementar paginación si el DAO la soporta
        $this->usuarios = $tmpUsuarios;
        $this->usuariosCount = count($tmpUsuarios);
        $this->pages = $this->usuariosCount > 0 ? ceil($this->usuariosCount / $this->itemsPerPage) : 1;

        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }

        foreach ($this->usuarios as &$usuario) {
            $usuario["userestDsc"] = match ($usuario["userest"]) {
                "ACT" => "Activo",
                "INA" => "Inactivo",
                default => "Desconocido"
            };
        }

        $this->setParamsToContext();
        $this->setParamsToDataView();
        Renderer::render("seguridad/usuarios", $this->viewData);
    }

    private function getParams(): void
    {
        $this->userEmail = $_GET["userEmail"] ?? $this->userEmail;
        $this->userName = $_GET["userName"] ?? $this->userName;

        $this->userStatus = isset($_GET["userStatus"]) && in_array($_GET["userStatus"], ["ACT", "INA", "EMP"]) ? $_GET["userStatus"] : $this->userStatus;
        if ($this->userStatus === "EMP") $this->userStatus = "";

        $this->orderBy = isset($_GET["orderBy"]) && in_array($_GET["orderBy"], ["usercod", "useremail", "username", "userest", "clear"]) ? $_GET["orderBy"] : $this->orderBy;
        if ($this->orderBy === "clear") $this->orderBy = "";

        $this->orderDescending = isset($_GET["orderDescending"]) ? boolval($_GET["orderDescending"]) : $this->orderDescending;
        $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
        $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
    }

    private function getParamsFromContext(): void
    {
        $this->userEmail = Context::getContextByKey("usuarios_userEmail");
        $this->userName = Context::getContextByKey("usuarios_userName");
        $this->userStatus = Context::getContextByKey("usuarios_userStatus");
        $this->orderBy = Context::getContextByKey("usuarios_orderBy");
        $this->orderDescending = boolval(Context::getContextByKey("usuarios_orderDescending"));
        $this->pageNumber = intval(Context::getContextByKey("usuarios_page"));
        $this->itemsPerPage = intval(Context::getContextByKey("usuarios_itemsPerPage"));

        if ($this->pageNumber < 1) $this->pageNumber = 1;
        if ($this->itemsPerPage < 1) $this->itemsPerPage = 10;

        $this->user_DSP = $this->isFeatureAutorized("Usuarios_DSP");
        $this->user_UPD = $this->isFeatureAutorized("Usuarios_UPD");
        $this->user_DEL = $this->isFeatureAutorized("Usuarios_DEL");
        $this->user_INS = $this->isFeatureAutorized("Usuarios_INS");
    }

    private function setParamsToContext(): void
    {
        Context::setContext("usuarios_userEmail", $this->userEmail, true);
        Context::setContext("usuarios_userName", $this->userName, true);
        Context::setContext("usuarios_userStatus", $this->userStatus, true);
        Context::setContext("usuarios_orderBy", $this->orderBy, true);
        Context::setContext("usuarios_orderDescending", $this->orderDescending, true);
        Context::setContext("usuarios_page", $this->pageNumber, true);
        Context::setContext("usuarios_itemsPerPage", $this->itemsPerPage, true);
    }

    private function setParamsToDataView(): void
    {
        $this->viewData["userEmail"] = $this->userEmail;
        $this->viewData["userName"] = $this->userName;
        $this->viewData["userStatus"] = $this->userStatus;
        $this->viewData["orderBy"] = $this->orderBy;
        $this->viewData["orderDescending"] = $this->orderDescending;
        $this->viewData["pageNum"] = $this->pageNumber;
        $this->viewData["itemsPerPage"] = $this->itemsPerPage;
        $this->viewData["usuariosCount"] = $this->usuariosCount;
        $this->viewData["pages"] = $this->pages;
        $this->viewData["usuarios"] = $this->usuarios;

        $this->viewData["user_DSP"] = $this->user_DSP;
        $this->viewData["user_UPD"] = $this->user_UPD;
        $this->viewData["user_DEL"] = $this->user_DEL;
        $this->viewData["user_INS"] = $this->user_INS;

        if ($this->orderBy !== "") {
            $orderByKey = "Order" . ucfirst($this->orderBy);
            $orderByKeyNoOrder = "OrderBy" . ucfirst($this->orderBy);
            $this->viewData[$orderByKeyNoOrder] = true;
            if ($this->orderDescending) {
                $orderByKey .= "Desc";
            }
            $this->viewData[$orderByKey] = true;
        }

        $statusKey = "userStatus_" . ($this->userStatus === "" ? "EMP" : $this->userStatus);
        $this->viewData[$statusKey] = "selected";

        $pagination = Paging::getPagination(
            $this->usuariosCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Seguridad_Usuarios",
            "Seguridad_Usuarios"
        );
        $this->viewData["pagination"] = $pagination;
    }
}
