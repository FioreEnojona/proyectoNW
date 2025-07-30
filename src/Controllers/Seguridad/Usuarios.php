<?php

namespace Controllers\Seguridad;

use Controllers\PrivateController;
use Utilities\Context;
use Utilities\Paging;
use Dao\Seguridad\Usuarios as DaoUsuarios;
use Views\Renderer;

class Usuarios extends PrivateController
{
    private $useremail = "";
    private $username = "";
    private $userest = "";
    private $orderBy = "";
    private $orderDescending = false;
    private $pageNumber = 1;
    private $itemsPerPage = 10;
    private $viewData = [];
    private $usuarios = [];
    private $usuariosCount = 0;
    private $pages = 0;
    private $canView = false;
    private $canEdit = false;
    private $canDelete = false;
    private $canInsert = false;

    public function run(): void
    {
        $this->getParamsFromContext();
        $this->getParams();

        $this->usuarios = DaoUsuarios::getUsuarios();
        $this->usuariosCount = count($this->usuarios);

        $this->applyFilters();
        $this->applySorting();
        $this->applyPagination();

        $this->prepareViewData();

        Renderer::render("seguridad/usuarios", $this->viewData);
    }

    private function applyFilters(): void
    {
        $this->usuarios = array_filter($this->usuarios, function ($usuario) {
            $matches = true;
            if ($this->useremail !== "" && stripos($usuario['useremail'], $this->useremail) === false) {
                $matches = false;
            }
            if ($this->username !== "" && stripos($usuario['username'], $this->username) === false) {
                $matches = false;
            }
            if ($this->userest !== "" && $usuario['userest'] !== $this->userest) {
                $matches = false;
            }
            return $matches;
        });
        $this->usuariosCount = count($this->usuarios);
    }

    private function applySorting(): void
    {
        if ($this->orderBy !== "") {
            usort($this->usuarios, function ($a, $b) {
                $cmp = strcmp($a[$this->orderBy], $b[$this->orderBy]);
                return $this->orderDescending ? -$cmp : $cmp;
            });
        }
    }

    private function applyPagination(): void
    {
        $this->pages = $this->usuariosCount > 0 ? ceil($this->usuariosCount / $this->itemsPerPage) : 1;

        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }

        $offset = ($this->pageNumber - 1) * $this->itemsPerPage;
        $this->usuarios = array_slice($this->usuarios, $offset, $this->itemsPerPage);
    }

    private function getParams(): void
    {
        $this->useremail = $_GET["useremail"] ?? $this->useremail;
        $this->username = $_GET["username"] ?? $this->username;

        $this->userest = isset($_GET["userest"]) && in_array($_GET["userest"], ['ACT', 'INA', 'EMP']) ?
            $_GET["userest"] : $this->userest;
        if ($this->userest === "EMP") {
            $this->userest = "";
        }

        $this->orderBy = isset($_GET["orderBy"]) && in_array($_GET["orderBy"], ["useremail", "username", "userest", ""]) ?
            $_GET["orderBy"] : $this->orderBy;

        $this->orderDescending = isset($_GET["orderDescending"]) ?
            boolval($_GET["orderDescending"]) : $this->orderDescending;

        $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
        $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
    }

    private function getParamsFromContext(): void
    {
        $this->useremail = Context::getContextByKey("usuarios_useremail");
        $this->username = Context::getContextByKey("usuarios_username");
        $this->userest = Context::getContextByKey("usuarios_userest");
        $this->orderBy = Context::getContextByKey("usuarios_orderBy");
        $this->orderDescending = boolval(Context::getContextByKey("usuarios_orderDescending"));
        $this->pageNumber = intval(Context::getContextByKey("usuarios_page"));
        $this->itemsPerPage = intval(Context::getContextByKey("usuarios_itemsPerPage"));

        $this->canView = $this->isFeatureAutorized("Usuarios_DSP");
        $this->canEdit = $this->isFeatureAutorized("Usuarios_UPD");
        $this->canDelete = $this->isFeatureAutorized("Usuarios_DEL");
        $this->canInsert = $this->isFeatureAutorized("Usuarios_INS");
    }

    private function prepareViewData(): void
    {
        $this->viewData = [
            "useremail" => $this->useremail,
            "username" => $this->username,
            "userest" => $this->userest,
            "orderBy" => $this->orderBy,
            "orderDescending" => $this->orderDescending,
            "pageNum" => $this->pageNumber,
            "itemsPerPage" => $this->itemsPerPage,
            "usuariosCount" => $this->usuariosCount,
            "pages" => $this->pages,
            "usuarios" => $this->usuarios,
            "canView" => $this->canView,
            "canEdit" => $this->canEdit,
            "canDelete" => $this->canDelete,
            "canInsert" => $this->canInsert,
            "userest_ACT" => $this->userest === "ACT" ? "selected" : "",
            "userest_INA" => $this->userest === "INA" ? "selected" : "",
            "userest_EMP" => $this->userest === "" ? "selected" : ""
        ];

        if ($this->orderBy !== "") {
            $this->viewData["orderBy_" . $this->orderBy] = true;
            if ($this->orderDescending) {
                $this->viewData["orderDesc"] = true;
            }
        }

        $this->viewData["pagination"] = Paging::getPagination(
            $this->usuariosCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Seguridad_Usuarios",
            "Seguridad_Usuarios"
        );
    }
}
