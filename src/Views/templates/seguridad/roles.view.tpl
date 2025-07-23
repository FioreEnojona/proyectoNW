<section class="depth-2 px-2 py-2">
    <h2>Listado de Roles</h2>
</section>
</section>
<section class="WWList my-4">
    <table>
        <thead>
            <tr >
                <th>ID</th>
                <th>Estado</th>
                <th>DSC</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            {{foreach roles}}
            <tr>
                <td>{{rolescod}}</td>
                <td>{{rolesest}}</td>
                <td>{{rolesdsc}}</td>
                <td>
                    <a href="index.php?page=Seguridad-Rol&mode=DSP&rolescod={{rolescod}}">
                        Ver
                    </a>
                    &nbsp;

                    <a href="index.php?page=Seguridad-Rol&mode=UPD&rolescod={{rolescod}}">
                        Editar
                    </a>
                    &nbsp;

                    <a href="index.php?page=Seguridad-Rol&mode=DEL&rolescod={{rolescod}}">
                        Eliminar
                    </a>
                </td>
            </tr>
            {{endfor roles}}
        </tbody>
    </table>
</section>