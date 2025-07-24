<section class="depth-2 px-2 py-2">
    <h2>Listado de Funciones</h2>
</section>
</section>
<section class="WWList my-4">
    <table>
        <thead>
            <tr >
                <th>ID</th>
                <th>Estado</th>
                <th>DSC</th>
                <th>Tipo</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            {{foreach funciones}}
            <tr>
                <td>{{fncod}}</td>
                <td>{{fndsc}}</td>
                <td>{{fnest}}</td>
                <td>{{fntyp}}</td>
                <td>
                    <a href="index.php?page=Seguridad-funcion&mode=DSP&fncod={{fncod}}">
                        Ver
                    </a>
                    &nbsp;

                    <a href="index.php?page=Seguridad-funcion&mode=UPD&fncod={{fncod}}">
                        Editar
                    </a>
                    &nbsp;

                    <a href="index.php?page=Seguridad-funcion&mode=DEL&fncod={{fncod}}">
                        Eliminar
                    </a>
                </td>
            </tr>
            {{endfor funciones}}
        </tbody>
    </table>
</section>