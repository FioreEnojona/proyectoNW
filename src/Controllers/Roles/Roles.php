<?php

namespace Controllers\Roles;

use Controllers\PrivateController;
use Utilities\Context;
use Utilities\Paging;
use Dao\Roles\Roles as RolesDao;
use Views\Renderer;

class Roles extends PrivateController
{
    private $roleCode = "";
    private $roleDescription = "";
    private $roleStatus = "";
    private $orderBy = "";
    private $orderDescending = false;
    private $pageNumber = 1;
    private $itemsPerPage = 10;
    private $viewData = [];
    private $roles = [];
    private $rolesCount = 0;
    private $pages = 0;
    private $role_DSP = false;
    private $role_UPD = false;
    private $role_DEL = false;
    private $role_INS = false;

    public function run(): void
    {
        $this->getParamsFromContext();
        $this->getParams();

        $tmpRoles = RolesDao::getRoles(
            $this->roleCode,
            $this->roleDescription,
            $this->roleStatus,
            $this->orderBy,
            $this->orderDescending,
            $this->pageNumber - 1,
            $this->itemsPerPage
        );

        $this->roles = $tmpRoles["roles"];
        $this->rolesCount = $tmpRoles["total"];
        $this->pages = $this->rolesCount > 0 ? ceil($this->rolesCount / $this->itemsPerPage) : 1;

        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }

        // Añadir descripción de estado
        foreach ($this->roles as &$rol) {
            $rol["rolStatusDsc"] = match($rol["rolesest"]) {
                "ACT" => "Activo",
                "INA" => "Inactivo",
                default => "Desconocido"
            };
        }

        $this->setParamsToContext();
        $this->setParamsToDataView();
        Renderer::render("roles/roles", $this->viewData);
    }

    private function getParams(): void
    {
        $this->roleCode = isset($_GET["roleCode"]) ? $_GET["roleCode"] : $this->roleCode;
        $this->roleDescription = isset($_GET["roleDescription"]) ? $_GET["roleDescription"] : $this->roleDescription;

        $this->roleStatus = isset($_GET["roleStatus"]) && in_array($_GET["roleStatus"], ['ACT', 'INA', 'EMP']) ? $_GET["roleStatus"] : $this->roleStatus;
        if ($this->roleStatus === "EMP") {
            $this->roleStatus = "";
        }

        $this->orderBy = isset($_GET["orderBy"]) && in_array($_GET["orderBy"], ["rolescod", "rolesdsc", "rolesest", "clear"]) ? $_GET["orderBy"] : $this->orderBy;
        if ($this->orderBy === "clear") {
            $this->orderBy = "";
        }

        $this->orderDescending = isset($_GET["orderDescending"]) ? boolval($_GET["orderDescending"]) : $this->orderDescending;
        $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
        $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
    }

    private function getParamsFromContext(): void
    {
        $this->roleCode = Context::getContextByKey("roles_roleCode");
        $this->roleDescription = Context::getContextByKey("roles_roleDescription");
        $this->roleStatus = Context::getContextByKey("roles_roleStatus");
        $this->orderBy = Context::getContextByKey("roles_orderBy");
        $this->orderDescending = boolval(Context::getContextByKey("roles_orderDescending"));
        $this->pageNumber = intval(Context::getContextByKey("roles_page"));
        $this->itemsPerPage = intval(Context::getContextByKey("roles_itemsPerPage"));

        if ($this->pageNumber < 1) $this->pageNumber = 1;
        if ($this->itemsPerPage < 1) $this->itemsPerPage = 10;

        $this->role_DSP = $this->isFeatureAutorized("Roles_DSP");
        $this->role_UPD = $this->isFeatureAutorized("Roles_UPD");
        $this->role_DEL = $this->isFeatureAutorized("Roles_DEL");
        $this->role_INS = $this->isFeatureAutorized("Roles_INS");
    }

    private function setParamsToContext(): void
    {
        Context::setContext("roles_roleCode", $this->roleCode, true);
        Context::setContext("roles_roleDescription", $this->roleDescription, true);
        Context::setContext("roles_roleStatus", $this->roleStatus, true);
        Context::setContext("roles_orderBy", $this->orderBy, true);
        Context::setContext("roles_orderDescending", $this->orderDescending, true);
        Context::setContext("roles_page", $this->pageNumber, true);
        Context::setContext("roles_itemsPerPage", $this->itemsPerPage, true);
    }

    private function setParamsToDataView(): void
    {
        $this->viewData["roleCode"] = $this->roleCode;
        $this->viewData["roleDescription"] = $this->roleDescription;
        $this->viewData["roleStatus"] = $this->roleStatus;
        $this->viewData["orderBy"] = $this->orderBy;
        $this->viewData["orderDescending"] = $this->orderDescending;
        $this->viewData["pageNum"] = $this->pageNumber;
        $this->viewData["itemsPerPage"] = $this->itemsPerPage;
        $this->viewData["rolesCount"] = $this->rolesCount;
        $this->viewData["pages"] = $this->pages;
        $this->viewData["roles"] = $this->roles;

        $this->viewData["role_DSP"] = $this->role_DSP;
        $this->viewData["role_UPD"] = $this->role_UPD;
        $this->viewData["role_DEL"] = $this->role_DEL;
        $this->viewData["role_INS"] = $this->role_INS;

        if ($this->orderBy !== "") {
            $orderByKey = "Order" . ucfirst($this->orderBy);
            $orderByKeyNoOrder = "OrderBy" . ucfirst($this->orderBy);
            $this->viewData[$orderByKeyNoOrder] = true;
            if ($this->orderDescending) {
                $orderByKey .= "Desc";
            }
            $this->viewData[$orderByKey] = true;
        }

        $statusKey = "roleStatus_" . ($this->roleStatus === "" ? "EMP" : $this->roleStatus);
        $this->viewData[$statusKey] = "selected";

        $pagination = Paging::getPagination(
            $this->rolesCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Roles_Roles",
            "Roles_Roles"
        );
        $this->viewData["pagination"] = $pagination;
    }
}
