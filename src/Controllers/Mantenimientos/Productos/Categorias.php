<?php

namespace Controllers\Mantenimientos\Productos;

use Controllers\PrivateController;
use Dao\Products\Categorias as CategoriasDAO;
use Utilities\Context;
use Utilities\Paging;
use Views\Renderer;

class Categorias extends PrivateController
{
    private array $viewData;
    private string $partialName = "";
    private string $status = "";
    private string $orderBy = "";
    private bool $orderDescending = false;
    private int $pageNumber = 1;
    private int $itemsPerPage = 10;
    private int $categoriasCount = 0;
    private int $pages = 1;
    private array $categorias = [];

    private bool $categorias_DSP = false;
    private bool $categorias_UPD = false;
    private bool $categorias_DEL = false;
    private bool $categorias_INS = false;

    public function run(): void
    {
        $this->getParamsFromContext();
        $this->getParams();

        $tmpCategorias = CategoriasDAO::getCategorias(
            $this->partialName,
            $this->status,
            $this->orderBy,
            $this->orderDescending,
            $this->pageNumber - 1,
            $this->itemsPerPage
        );

        $this->categorias = $tmpCategorias["categorias"];
        $this->categoriasCount = $tmpCategorias["total"];
        $this->pages = $this->categoriasCount > 0 ? ceil($this->categoriasCount / $this->itemsPerPage) : 1;

        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }

        $this->setParamsToContext();
        $this->setViewData();
        Renderer::render("mnt/productos/categorias", $this->viewData);
    }

    private function getParams(): void
    {
        $this->partialName = $_GET["partialName"] ?? $this->partialName;
        $this->status = isset($_GET["status"]) && in_array($_GET["status"], ['ACT', 'INA', 'EMP']) ? $_GET["status"] : $this->status;
        if ($this->status === "EMP") {
            $this->status = "";
        }
        $this->orderBy = in_array($_GET["orderBy"] ?? "", ["id", "nombre", "clear"]) ? $_GET["orderBy"] : $this->orderBy;
        if ($this->orderBy === "clear") {
            $this->orderBy = "";
        }
        $this->orderDescending = isset($_GET["orderDescending"]) ? boolval($_GET["orderDescending"]) : $this->orderDescending;
        $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
        $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
    }

    private function getParamsFromContext(): void
    {
        $this->partialName = Context::getContextByKey("categorias_partialName");
        $this->status = Context::getContextByKey("categorias_status");
        $this->orderBy = Context::getContextByKey("categorias_orderBy");
        $this->orderDescending = boolval(Context::getContextByKey("categorias_orderDescending"));
        $this->pageNumber = intval(Context::getContextByKey("categorias_page"));
        $this->itemsPerPage = intval(Context::getContextByKey("categorias_itemsPerPage"));

        $this->categorias_DSP = $this->isFeatureAutorized("categorias_DSP");
        $this->categorias_UPD = $this->isFeatureAutorized("categorias_UPD");
        $this->categorias_DEL = $this->isFeatureAutorized("categorias_DEL");
        $this->categorias_INS = $this->isFeatureAutorized("categorias_INS");

        if ($this->pageNumber < 1) $this->pageNumber = 1;
        if ($this->itemsPerPage < 1) $this->itemsPerPage = 10;
    }

    private function setParamsToContext(): void
    {
        Context::setContext("categorias_partialName", $this->partialName, true);
        Context::setContext("categorias_status", $this->status, true);
        Context::setContext("categorias_orderBy", $this->orderBy, true);
        Context::setContext("categorias_orderDescending", $this->orderDescending, true);
        Context::setContext("categorias_page", $this->pageNumber, true);
        Context::setContext("categorias_itemsPerPage", $this->itemsPerPage, true);
    }

    private function setViewData(): void
    {
        $this->viewData = [
            "partialName" => $this->partialName,
            "status" => $this->status,
            "orderBy" => $this->orderBy,
            "orderDescending" => $this->orderDescending,
            "pageNum" => $this->pageNumber,
            "itemsPerPage" => $this->itemsPerPage,
            "categoriasCount" => $this->categoriasCount,
            "pages" => $this->pages,
            "categorias" => $this->categorias,
            "categoria_DSP" => $this->categorias_DSP,
            "categoria_UPD" => $this->categorias_UPD,
            "categoria_DEL" => $this->categorias_DEL,
            "categoria_INS" => $this->categorias_INS
        ];

        if ($this->orderBy !== "") {
            $orderByKey = "Order" . ucfirst($this->orderBy);
            $orderByKeyNoOrder = "OrderBy" . ucfirst($this->orderBy);
            $this->viewData[$orderByKeyNoOrder] = true;
            if ($this->orderDescending) {
                $orderByKey .= "Desc";
            }
            $this->viewData[$orderByKey] = true;
        }

        $statusKey = "status_" . ($this->status === "" ? "EMP" : $this->status);
        $this->viewData[$statusKey] = "selected";

        $pagination = Paging::getPagination(
            $this->categoriasCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Mantenimientos_Productos_Categorias",
            "Mantenimientos_Productos_Categorias"
        );

        $this->viewData["pagination"] = $pagination;
    }
}
