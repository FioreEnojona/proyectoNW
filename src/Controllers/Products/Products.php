<?php

namespace Controllers\Products;

use Controllers\PrivateController;
use Utilities\Context;
use Utilities\Paging;
use Dao\Products\Products as DaoProducts;
use Views\Renderer;

class Products extends PrivateController
{
    private $partialName = "";
    private $status = "";
    private $orderBy = "";
    private $orderDescending = false;
    private $pageNumber = 1;
    private $itemsPerPage = 10;
    private $categoriaId = 0;
    private $viewData = [];
    private $products = [];
    private $productsCount = 0;
    private $pages = 0;
    private $product_DSP = false;
    private $product_UPD = false;
    private $product_DEL = false;
    private $product_INS = false;

    public function run(): void
    {
        $this->getParamsFromContext();
        $this->getParams();
        $tmpProducts = DaoProducts::getProducts(
            $this->partialName,
            $this->status,
            $this->orderBy,
            $this->orderDescending,
            $this->pageNumber - 1,
            $this->itemsPerPage,
            $this->categoriaId
        );
        $this->products = $tmpProducts["products"];
        $this->productsCount = $tmpProducts["total"];
        $this->pages = $this->productsCount > 0 ? ceil($this->productsCount / $this->itemsPerPage) : 1;
        if ($this->pageNumber > $this->pages) {
            $this->pageNumber = $this->pages;
        }
        $this->setParamsToContext();
        $this->setParamsToDataView();
        Renderer::render("products", $this->viewData);
    }

    private function getParams(): void
    {
        $this->partialName = isset($_GET["partialName"]) ? $_GET["partialName"] : $this->partialName;
        $this->status = isset($_GET["status"]) && in_array($_GET["status"], ['ACT', 'INA', 'EMP']) ? $_GET["status"] : $this->status;
        if ($this->status === "EMP") {
            $this->status = "";
        }
        $this->orderBy = isset($_GET["orderBy"]) && in_array($_GET["orderBy"], ["productId", "productName", "productPrice", "clear"]) ? $_GET["orderBy"] : $this->orderBy;
        if ($this->orderBy === "clear") {
            $this->orderBy = "";
        }
        $this->orderDescending = isset($_GET["orderDescending"]) ? boolval($_GET["orderDescending"]) : $this->orderDescending;
        $this->pageNumber = isset($_GET["pageNum"]) ? intval($_GET["pageNum"]) : $this->pageNumber;
        $this->itemsPerPage = isset($_GET["itemsPerPage"]) ? intval($_GET["itemsPerPage"]) : $this->itemsPerPage;
        $this->categoriaId = isset($_GET["categoriaId"]) ? intval($_GET["categoriaId"]) : $this->categoriaId;
    }

    private function getParamsFromContext(): void
    {
        $this->partialName = Context::getContextByKey("products_partialName");
        $this->status = Context::getContextByKey("products_status");
        $this->orderBy = Context::getContextByKey("products_orderBy");
        $this->orderDescending = boolval(Context::getContextByKey("products_orderDescending"));
        $this->pageNumber = intval(Context::getContextByKey("products_page"));
        $this->itemsPerPage = intval(Context::getContextByKey("products_itemsPerPage"));
        $this->categoriaId = intval(Context::getContextByKey("products_categoriaId"));
        $this->product_DSP = $this->isFeatureAutorized("Products_DSP");
        $this->product_UPD = $this->isFeatureAutorized("Products_UPD");
        $this->product_DEL = $this->isFeatureAutorized("Products_DEL");
        $this->product_INS = $this->isFeatureAutorized("Products_INS");
        if ($this->pageNumber < 1) $this->pageNumber = 1;
        if ($this->itemsPerPage < 1) $this->itemsPerPage = 10;
    }

    private function setParamsToContext(): void
    {
        Context::setContext("products_partialName", $this->partialName, true);
        Context::setContext("products_status", $this->status, true);
        Context::setContext("products_orderBy", $this->orderBy, true);
        Context::setContext("products_orderDescending", $this->orderDescending, true);
        Context::setContext("products_page", $this->pageNumber, true);
        Context::setContext("products_itemsPerPage", $this->itemsPerPage, true);
        Context::setContext("products_categoriaId", $this->categoriaId, true);
    }

    private function setParamsToDataView(): void
    {
        $this->viewData["partialName"] = $this->partialName;
        $this->viewData["status"] = $this->status;
        $this->viewData["orderBy"] = $this->orderBy;
        $this->viewData["orderDescending"] = $this->orderDescending;
        $this->viewData["pageNum"] = $this->pageNumber;
        $this->viewData["itemsPerPage"] = $this->itemsPerPage;
        $this->viewData["productsCount"] = $this->productsCount;
        $this->viewData["pages"] = $this->pages;
        $this->viewData["products"] = $this->products;
        $this->viewData["product_DSP"] = $this->product_DSP;
        $this->viewData["product_UPD"] = $this->product_UPD;
        $this->viewData["product_DEL"] = $this->product_DEL;
        $this->viewData["product_INS"] = $this->product_INS;
        $this->viewData["categoriaId"] = $this->categoriaId;

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
            $this->productsCount,
            $this->itemsPerPage,
            $this->pageNumber,
            "index.php?page=Products_Products",
            "Products_Products"
        );

        $this->viewData["pagination"] = $pagination;
    }
}
