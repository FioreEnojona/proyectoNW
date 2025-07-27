<?php

namespace Controllers\Generator;

class GeneratorHelper
{
    private $keyColumns = [];
    private $columns = [];
    private $table = "";
    private $noKeyColumns = [];

    public function __construct($columns, $table)
    {
        $this->columns  = $columns;
        $this->table = $table;
        $this->setKeyColumns();
    }
    private function setKeyColumns()
    {
        foreach ($this->columns as $column) {
            if ($column["Key"] == "PRI") {
                $this->keyColumns[] = $column;
            } else {
                $this->noKeyColumns[] = $column;
            }
        }
    }

    public function getDaoPhpCode()
    {
        $className = ucfirst($this->table);
        $idColumn = $this->keyColumns[0]["Field"] ?? "id";

        $code = [];
        $code[] = "<?php";
        $code[] = "";
        $code[] = "";
        $code[] = "namespace Dao\{$className};";
        $code[] = "use Dao\Table;";
        $code[] = "";
        $code[] = "class {$className} extends Table";
        $code[] = "{";
        $code[] = "    public static function getAll()";
        $code[] = "    {";
        $code[] = "        return self::obtenerRegistros(\"SELECT * FROM {$this->table};\", []);";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    public static function getById(int \${$idColumn})";
        $code[] = "    {";
        $code[] = "        return self::obtenerUnRegistro(\"SELECT * FROM {$this->table} WHERE {$idColumn} = :{$idColumn};\", [\"{$idColumn}\" => \${$idColumn}]);";
        $code[] = "    }";
        $code[] = "";
        $noKeyCols = array_column($this->noKeyColumns, 'Field');
        $placeholders = array_map(fn($c) => ":$c", $noKeyCols);
        $paramsList = implode(', ', array_map(fn($c) => "string \$$c", $noKeyCols));
        $fieldsList = implode(', ', $noKeyCols);
        $phList = implode(', ', $placeholders);

        $code[] = "    public static function insert($paramsList)";
        $code[] = "    {";
        $code[] = "        \$sql = \"INSERT INTO {$this->table} ({$fieldsList}) VALUES ({$phList});\";";
        $code[] = "        return self::executeNonQuery(\$sql, [";

        foreach ($noKeyCols as $col) {
            $code[] = "            \"{$col}\" => \${$col},";
        }

        $code[] = "        ]);";
        $code[] = "    }";
        $code[] = "";
        $updateSet = implode(', ', array_map(fn($c) => "$c = :$c", $noKeyCols));
        $paramsUpdateList = implode(', ', array_map(fn($c) => "string \$$c", $noKeyCols));
        $code[] = "    public static function update(int \${$idColumn}, $paramsUpdateList)";
        $code[] = "    {";
        $code[] = "        \$sql = \"UPDATE {$this->table} SET {$updateSet} WHERE {$idColumn} = :{$idColumn};\";";
        $code[] = "        return self::executeNonQuery(\$sql, [";

        foreach ($noKeyCols as $col) {
            $code[] = "            \"{$col}\" => \${$col},";
        }
        $code[] = "            \"{$idColumn}\" => \${$idColumn}";
        $code[] = "        ]);";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    public static function delete(int \${$idColumn})";
        $code[] = "    {";
        $code[] = "        \$sql = \"DELETE FROM {$this->table} WHERE {$idColumn} = :{$idColumn};\";";
        $code[] = "        return self::executeNonQuery(\$sql, [\"{$idColumn}\" => \${$idColumn}]);";
        $code[] = "    }";

        $code[] = "}";
        return $this->escapeHtmlChars(implode("\n", $code));
    }

    public function getControllerPhpCode(): string
    {
        $className = ucfirst($this->table);
        $daoClass = $className . 'DAO';
        $namespace = "Controllers\\Mantenimientos\\$className";
        $idField = $this->keyColumns[0]["Field"] ?? "id";

        $viewData = [];
        foreach ($this->columns as $col) {
            $default = $col["Field"] === $idField ? "0" : "\"\"";
            $viewData[] = "\"{$col["Field"]}\" => {$default},";
        }

        $formInputs = [];
        $validations = [];
        foreach ($this->noKeyColumns as $col) {
            $field = $col["Field"];
            $formInputs[] = "        if (isset(\$_POST[\"$field\"])) \$this->viewData[\"$field\"] = \$_POST[\"$field\"];";
            $validations[] = "        if (Validators::IsEmpty(\$this->viewData[\"$field\"])) \$this->viewData[\"errores\"][\"$field\"] = \"El campo $field es requerido\";";
        }

        $insertParams = implode(", ", array_map(fn($c) => '$this->viewData["' . $c["Field"] . '"]', $this->noKeyColumns));
        $updateParams = '$this->viewData["' . $idField . '"], ' . $insertParams;

        $code = [];
        $code[] = "<?php";
        $code[] = "namespace $namespace;";
        $code[] = "";
        $code[] = "use Controllers\PublicController;";
        $code[] = "use Dao\\$className\\$className as $daoClass;";
        $code[] = "use Utilities\Site;";
        $code[] = "use Utilities\Validators;";
        $code[] = "use Views\Renderer;";
        $code[] = "";
        $code[] = "const LIST_URL = \"index.php?page=Mantenimientos-{$className}-{$className}\";";
        $code[] = "const XSR_KEY = \"xsrToken_{$this->table}\";";
        $code[] = "";
        $code[] = "class $className extends PublicController";
        $code[] = "{";
        $code[] = "    private array \$viewData = [";
        $code[] = "        " . implode("\n        ", $viewData);
        $code[] = "        \"mode\" => \"\",";
        $code[] = "        \"modeDsc\" => \"\",";
        $code[] = "        \"errores\" => [],";
        $code[] = "        \"readonly\" => \"\",";
        $code[] = "        \"showAction\" => true,";
        $code[] = "        \"xsrToken\" => \"\"";
        $code[] = "    ];";
        $code[] = "";
        $code[] = "    private array \$modes = [";
        $code[] = "        \"INS\" => 'Creando nuevo $className',";
        $code[] = "        \"UPD\" => 'Modificando $className %s',";
        $code[] = "        \"DEL\" => 'Eliminando $className %s',";
        $code[] = "        \"DSP\" => 'Detalle de $className %s'";
        $code[] = "    ];";
        $code[] = "";
        $code[] = "    public function run(): void";
        $code[] = "    {";
        $code[] = "        \$this->capturarModo();";
        $code[] = "        \$this->datosDao();";
        $code[] = "        if (\$this->isPostBack()) {";
        $code[] = "            \$this->leerFormulario();";
        $code[] = "            \$this->validarFormulario();";
        $code[] = "            if (count(\$this->viewData[\"errores\"]) === 0) {";
        $code[] = "                \$this->procesar();";
        $code[] = "            }";
        $code[] = "        }";
        $code[] = "        \$this->prepararVista();";
        $code[] = "        Renderer::render(\"mnt/{$this->table}/{$this->table}\", \$this->viewData);";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    private function capturarModo()";
        $code[] = "    {";
        $code[] = "        if (!isset(\$_GET[\"mode\"]) || !isset(\$this->modes[\$_GET[\"mode\"]])) {";
        $code[] = "            Site::redirectToWithMsg(LIST_URL, \"Modo inválido\");";
        $code[] = "        }";
        $code[] = "        \$this->viewData[\"mode\"] = \$_GET[\"mode\"];";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    private function datosDao()";
        $code[] = "    {";
        $code[] = "        if (\$this->viewData[\"mode\"] !== \"INS\" && isset(\$_GET[\"id\"])) {";
        $code[] = "            \$this->viewData[\"$idField\"] = intval(\$_GET[\"id\"]);";
        $code[] = "            \$tmp = $daoClass::getById(\$this->viewData[\"$idField\"]);";
        $code[] = "            if (\$tmp) {";
        $code[] = "                foreach (\$tmp as \$key => \$value) {";
        $code[] = "                    if (isset(\$this->viewData[\$key])) \$this->viewData[\$key] = \$value;";
        $code[] = "                }";
        $code[] = "            } else {";
        $code[] = "                Site::redirectToWithMsg(LIST_URL, \"Registro no existe\");";
        $code[] = "            }";
        $code[] = "        }";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    private function leerFormulario()";
        $code[] = "    {";
        $code[] = implode("\n", $formInputs);
        $code[] = "        if (isset(\$_POST[\"xsrToken\"])) \$this->viewData[\"xsrToken\"] = \$_POST[\"xsrToken\"];";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    private function validarFormulario()";
        $code[] = "    {";
        $code[] = implode("\n", $validations);
        $code[] = "        if (\$_SESSION[XSR_KEY] !== \$this->viewData[\"xsrToken\"]) {";
        $code[] = "            Site::redirectToWithMsg(LIST_URL, \"Token inválido\");";
        $code[] = "        }";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    private function procesar()";
        $code[] = "    {";
        $code[] = "        switch (\$this->viewData[\"mode\"]) {";
        $code[] = "            case \"INS\":";
        $code[] = "                if ($daoClass::insert($insertParams)) {";
        $code[] = "                    Site::redirectToWithMsg(LIST_URL, \"$className creado\");";
        $code[] = "                }";
        $code[] = "                break;";
        $code[] = "            case \"UPD\":";
        $code[] = "                if ($daoClass::update($updateParams)) {";
        $code[] = "                    Site::redirectToWithMsg(LIST_URL, \"$className actualizado\");";
        $code[] = "                }";
        $code[] = "                break;";
        $code[] = "            case \"DEL\":";
        $code[] = "                if ($daoClass::delete(\$this->viewData[\"$idField\"])) {";
        $code[] = "                    Site::redirectToWithMsg(LIST_URL, \"$className eliminado\");";
        $code[] = "                }";
        $code[] = "                break;";
        $code[] = "        }";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    private function prepararVista()";
        $code[] = "    {";
        $code[] = "        \$this->viewData[\"modeDsc\"] = sprintf(\$this->modes[\$this->viewData[\"mode\"]], \$this->viewData[\"$idField\"]);";
        $code[] = "        if (in_array(\$this->viewData[\"mode\"], [\"DEL\", \"DSP\"])) \$this->viewData[\"readonly\"] = \"readonly\";";
        $code[] = "        if (\$this->viewData[\"mode\"] === \"DSP\") \$this->viewData[\"showAction\"] = false;";
        $code[] = "        \$this->viewData[\"xsrToken\"] = hash(\"sha256\", random_int(0, 1000000) . time());";
        $code[] = "        \$_SESSION[XSR_KEY] = \$this->viewData[\"xsrToken\"];";
        $code[] = "    }";

        $code[] = "}";

        return $this->escapeHtmlChars(implode("\n", $code));
    }
    public function getSimpleControllerPhpCode(): string
    {
        $className = ucfirst($this->table);
        $namespace = "Controllers\\Mantenimientos\\$className";
        $daoClass = "Dao\\{$className}";

        $code = [];
        $code[] = "<?php";
        $code[] = "";
        $code[] = "namespace $namespace;";
        $code[] = "";
        $code[] = "use Controllers\\PublicController;";
        $code[] = "use $daoClass as {$className}DAO;";
        $code[] = "use Views\\Renderer;";
        $code[] = "";
        $code[] = "class $className extends PublicController";
        $code[] = "{";
        $code[] = "    private array \$viewData;";
        $code[] = "";
        $code[] = "    public function __construct()";
        $code[] = "    {";
        $code[] = "        \$this->viewData = [";
        $code[] = "            \"{$this->table}\" => []";
        $code[] = "        ];";
        $code[] = "    }";
        $code[] = "";
        $code[] = "    public function run(): void";
        $code[] = "    {";
        $code[] = "        \$this->viewData[\"{$this->table}\"] = {$className}DAO::getAll();";
        $code[] = "        Renderer::render(\"mnt/{$this->table}/{$this->table}\", \$this->viewData);";
        $code[] = "    }";
        $code[] = "}";

        return $this->escapeHtmlChars(implode("\n", $code));
    }
    public function getFormTemplateCode(): string
    {
        $idField = $this->keyColumns[0]["Field"] ?? "id";

        $hasCategoria = false;
        $hasEstado = false;
        foreach ($this->columns as $col) {
            if ($col["Field"] === "categoria") $hasCategoria = true;
            if ($col["Field"] === "estado") $hasEstado = true;
        }

        $code = [];

        $code[] = "<section class=\"depth-2 px-2 py-2\">";
        $code[] = "    <h2>{{modeDsc}}</h2>";
        $code[] = "</section>";
        $code[] = "<section class=\"grid py-4 px-4 my-4\">";
        $code[] = "    <div class=\"row\">";
        $code[] = "        <div class=\"col-12 offset-m-1 col-m-10 offset-l-3 col-l-6\">";
        $code[] = "            <form class=\"row\" action=\"index.php?page=Mantenimientos-Productos-Categoria&mode={{mode}}&id={{$idField}}\" method=\"post\">";
        $code[] = "                <div class=\"row\">";
        $code[] = "                    <label for=\"$idField\" class=\"col-12 col-m-4\">Id</label>";
        $code[] = "                    <input readonly type=\"text\" class=\"col-12 col-m-8\" name=\"$idField\" id=\"$idField\" value=\"{{{$idField}}}\" />";
        $code[] = "                    <input type=\"hidden\" name=\"xsrToken\" value=\"{{xsrToken}}\" />";
        $code[] = "                </div>";

        if ($hasCategoria) {
            $code[] = "                <div class=\"row\">";
            $code[] = "                    <label for=\"categoria\" class=\"col-12 col-m-4\">Categoría</label>";
            $code[] = "                    <input type=\"text\" class=\"col-12 col-m-8\" name=\"categoria\" id=\"categoria\" value=\"{{categoria}}\"  {{readonly}}/>";
            $code[] = "                    {{if error_categoria}} ";
            $code[] = "                        <span class=\"error col-12 col-m-8\">{{error_categoria}}</span>";
            $code[] = "                    {{endif error_categoria}}";
            $code[] = "                </div>";
        }

        if ($hasEstado) {
            $code[] = "                <div class=\"row\">";
            $code[] = "                    <label for=\"estado\" class=\"col-12 col-m-4\">Estado</label>";
            $code[] = "                    <select id=\"estado\" name=\"estado\"  {{if readonly}}readonly disabled{{endif readonly}} >";
            $code[] = "                        <option value=\"ACT\" {{estadoACT}}>Activo</option>";
            $code[] = "                        <option value=\"INA\" {{estadoINA}}>Inactivo</option>";
            $code[] = "                        <option value=\"RTR\" {{estadoRTR}}>Retirado</option>";
            $code[] = "                    </select>";
            $code[] = "                     {{if error_estado}} ";
            $code[] = "                        <span class=\"error col-12 col-m-8\">{{error_estado}}</span>";
            $code[] = "                    {{endif error_estado}}";
            $code[] = "                </div>";
        }

        $code[] = "                <div class=\"row flex-end\">";
        $code[] = "                    <button id=\"btnCancel\">";
        $code[] = "                        {{if showAction}}";
        $code[] = "                            Cancel";
        $code[] = "                        {{endif showAction}}";
        $code[] = "                        {{ifnot showAction}}";
        $code[] = "                            Volver";
        $code[] = "                        {{endifnot showAction}}";
        $code[] = "                    </button>";
        $code[] = "                    &nbsp;";
        $code[] = "                    {{if showAction}}";
        $code[] = "                    <button class=\"primary\">Confirmar</button>";
        $code[] = "                    {{endif showAction}}";
        $code[] = "                </div>";

        $code[] = "                {{if error_global}}";
        $code[] = "                    {{foreach error_global}}";
        $code[] = "                        <div class=\"error col-12 col-m-8\">{{this}}</div>";
        $code[] = "                    {{endfor error_global}}";
        $code[] = "                {{endif error_global}}";

        $code[] = "            </form>";
        $code[] = "        </div>";
        $code[] = "    </div>";
        $code[] = "</section>";

        $code[] = "<script>";
        $code[] = "    document.addEventListener(\"DOMContentLoaded\", ()=>{";
        $code[] = "        document.getElementById(\"btnCancel\").addEventListener(\"click\", (e)=>{";
        $code[] = "            e.preventDefault();";
        $code[] = "            e.stopPropagation();";
        $code[] = "            window.location.assign(\"index.php?page=Mantenimientos-Productos-Categorias\")";
        $code[] = "        });";
        $code[] = "    });";
        $code[] = "</script>";

        return $this->escapeHtmlChars(implode("\n", $code));
    }
    public function getListTemplateCode(): string
    {
        $tableVar = $this->table;

        $code = [];

        $code[] = "<section class=\"depth-2 px-2 py-2\">";
        $code[] = "    <h2>Mantenimiento de " . ucfirst($tableVar) . "</h2>";
        $code[] = "</section>";
        $code[] = "<section class=\"WWList my-4\">";
        $code[] = "    <table>";
        $code[] = "        <thead>";
        $code[] = "            <tr>";
        $code[] = "                <th>Id</th>";
        $code[] = "                <th>Categoría</th>";
        $code[] = "                <th>Estado</th>";
        $code[] = "                <th>";
        $code[] = "                    <a href=\"index.php?page=Mantenimientos-Productos-Categoria&mode=INS&id=\">";
        $code[] = "                        Nuevo";
        $code[] = "                    </a>";
        $code[] = "                </th>";
        $code[] = "            </tr>";
        $code[] = "        </thead>";
        $code[] = "        <tbody>";
        $code[] = "            {{foreach $tableVar}}";
        $code[] = "            <tr>";
        $code[] = "                <td>{{id}}</td>";
        $code[] = "                <td>{{categoria}}</td>";
        $code[] = "                <td>{{estado}}</td>";
        $code[] = "                <td>";
        $code[] = "                    <a href=\"index.php?page=Mantenimientos-Productos-Categoria&mode=DSP&id={{id}}\">";
        $code[] = "                        Ver";
        $code[] = "                    </a>";
        $code[] = "                    &nbsp;";
        $code[] = "                    <a href=\"index.php?page=Mantenimientos-Productos-Categoria&mode=UPD&id={{id}}\">";
        $code[] = "                        Editar";
        $code[] = "                    </a>";
        $code[] = "                    &nbsp;";
        $code[] = "                    <a href=\"index.php?page=Mantenimientos-Productos-Categoria&mode=DEL&id={{id}}\">";
        $code[] = "                        Eliminar";
        $code[] = "                    </a>";
        $code[] = "                </td>";
        $code[] = "            </tr>";
        $code[] = "            {{endfor $tableVar}}";
        $code[] = "        </tbody>";
        $code[] = "    </table>";
        $code[] = "</section>";

        return $this->escapeHtmlChars(implode("\n", $code));
    }

    private function escapeHtmlChars($string)
    {
        return htmlspecialchars($string, ENT_QUOTES, "UTF-8");
    }
}
