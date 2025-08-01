<section class="depth-2 px-2 py-2">
    <h2>Mantenimiento de Categorías</h2>
</section>
<section class="WWList my-4">
    <table>
        <thead>
            <tr>
                <th>Id</th>
                <th>Categoría</th>
                <th>Estado</th>
                <th>Acciones</th>
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach categorias}}
            <tr>
                <td>{{id}}</td>
                <td>{{nombre}}</td>
                <td>{{estado}}</td>
                <td>
                    <a href="index.php?page=Mantenimientos-Productos-Categoria&mode=DSP&id={{id}}">
                        Ver
                    </a>
                    &nbsp;
                    <a href="index.php?page=Mantenimientos-Productos-Categoria&mode=UPD&id={{id}}">
                        Editar
                    </a>
                    &nbsp;
                    <a href="index.php?page=Mantenimientos-Productos-Categoria&mode=DEL&id={{id}}">
                        Eliminar
                    </a>
                    &nbsp;
                    <a href="index.php?page=Mantenimientos-Productos-Categoria&mode=INS&id={{id}}">
                        Nuevo
                    </a>
                </td>
            </tr>
            {{endfor categorias}}
        </tbody>
    </table>
</section>