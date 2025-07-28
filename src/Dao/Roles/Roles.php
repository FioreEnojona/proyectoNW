<?php
namespace Dao\Roles;

use Dao\Table;

class Roles extends Table
{
    public static function getRoles(
        string $partialCode = "",
        string $partialDescription = "",
        string $status = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT r.rolescod, r.rolesdsc, r.rolesest, 
            CASE 
                WHEN r.rolesest = 'ACT' THEN 'Activo' 
                WHEN r.rolesest = 'INA' THEN 'Inactivo' 
                ELSE 'Sin Asignar' 
            END AS rolesestDsc
            FROM roles r";

        $sqlstrCount = "SELECT COUNT(*) as count FROM roles r";

        $conditions = [];
        $params = [];

        if ($partialCode !== "") {
            $conditions[] = "r.rolescod LIKE :partialCode";
            $params["partialCode"] = "%" . $partialCode . "%";
        }

        if ($partialDescription !== "") {
            $conditions[] = "r.rolesdsc LIKE :partialDescription";
            $params["partialDescription"] = "%" . $partialDescription . "%";
        }

        if (!in_array($status, ["ACT", "INA", ""])) {
            throw new \Exception("Error Processing Request: Status has invalid value");
        }
        if ($status !== "") {
            $conditions[] = "r.rolesest = :status";
            $params["status"] = $status;
        }

        if (count($conditions) > 0) {
            $whereClause = " WHERE " . implode(" AND ", $conditions);
            $sqlstr .= $whereClause;
            $sqlstrCount .= $whereClause;
        }

        $validOrderBy = ["rolescod", "rolesdsc", "rolesest", ""];
        if (!in_array($orderBy, $validOrderBy)) {
            throw new \Exception("Error Processing Request: OrderBy has invalid value");
        }

        if ($orderBy !== "") {
            $sqlstr .= " ORDER BY " . $orderBy;
            if ($orderDescending) {
                $sqlstr .= " DESC";
            }
        }

        $totalRecords = self::obtenerUnRegistro($sqlstrCount, $params)["count"];
        $pagesCount = $itemsPerPage > 0 ? ceil($totalRecords / $itemsPerPage) : 1;

        if ($page < 0) {
            $page = 0;
        } elseif ($page > $pagesCount - 1) {
            $page = max(0, $pagesCount - 1);
        }

        $sqlstr .= " LIMIT " . ($page * $itemsPerPage) . ", " . $itemsPerPage;

        $records = self::obtenerRegistros($sqlstr, $params);

        return [
            "roles" => $records,
            "total" => $totalRecords,
            "page" => $page,
            "itemsPerPage" => $itemsPerPage
        ];
    }

    public static function getRoleByCode(string $rolescod)
    {
        $sqlstr = "SELECT rolescod, rolesdsc, rolesest FROM roles WHERE rolescod = :rolescod";
        $params = ["rolescod" => $rolescod];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertRole(
        string $rolescod,
        string $rolesdsc,
        string $rolesest
    ) {
        $sqlstr = "INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES (:rolescod, :rolesdsc, :rolesest)";
        $params = [
            "rolescod" => $rolescod,
            "rolesdsc" => $rolesdsc,
            "rolesest" => $rolesest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function updateRole(
        string $rolescod,
        string $rolesdsc,
        string $rolesest
    ) {
        $sqlstr = "UPDATE roles SET rolesdsc = :rolesdsc, rolesest = :rolesest WHERE rolescod = :rolescod";
        $params = [
            "rolescod" => $rolescod,
            "rolesdsc" => $rolesdsc,
            "rolesest" => $rolesest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteRole(string $rolescod)
    {
        $sqlstr = "DELETE FROM roles WHERE rolescod = :rolescod";
        $params = ["rolescod" => $rolescod];
        return self::executeNonQuery($sqlstr, $params);
    }
}
