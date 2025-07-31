<section class="depth-2 px-2 py-2">
    <h2>Listado de Usuarios</h2>
</section>
</section>
<section class="table-container my-4">
<table class="centered-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Correo</th>
                <th>Nombre</th>
                <th>Contraseña</th>
                <th>Fecha de Creación</th>
                <th>Estado Contraseña</th>
                <th>Expiración Contraseña</th>
                <th>Estado Usuario</th>
                <th>Código de Activación</th>
                <th>Última Modificación Contraseña</th>
                <th>Tipo de Usuario</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            {{foreach usuarios}}
            <tr>
                <td>{{usercod}}</td>
                <td>{{useremail}}</td>
                <td>{{username}}</td>
                <td>{{userpswd}}</td>
                <td>{{userfching}}</td>
                <td>{{userpswdest}}</td>
                <td>{{userpswdexp}}</td>
                <td>{{userest}}</td>
                <td>{{useractcod}}</td>
                <td>{{userpswdchg}}</td>
                <td>{{usertipo}}</td>
                <td>
                    <a href="index.php?page=Seguridad-Usuario&mode=DSP&id={{usercod}}">
                        Ver
                    </a>
                    &nbsp;
                    <a href="index.php?page=Seguridad-Usuario&mode=UPD&id={{usercod}}">
                        Editar
                    </a>
                    &nbsp;
                    <a href="index.php?page=Seguridad-Usuario&mode=DEL&id={{usercod}}">
                        Eliminar
                    </a>
                    &nbsp;
                    <a href="index.php?page=Seguridad-Usuario&mode=INS&id={{usercod}}">
                        Nuevo
                    </a>
                    &nbsp;

                </td>
            </tr>
            {{endfor usuarios}}
        </tbody>
    </table>
</section>