
<section class="depth-2 px-2 py-2">
<h1>Historial de Compras</h1></section>
<section class="WWList my-4">
    {{if bitacoras}}
<table>
    <thead>
        <tr>
            <th>Fecha</th>
            <th>Producto</th>
            <th>Descripción</th>
            <th>Observación</th>
            <th>Tipo</th>
            <th>Usuario</th>
        </tr>
    </thead>
    <tbody>
        {{foreach bitacoras}}
        <tr>
            <td>{{bitacorafch}}</td>
            <td>{{bitprograma}}</td>
            <td>{{bitdescripcion}}</td>
            <td>{{bitobservacion}}</td>
            <td>{{bitTipo}}</td>
            <td>{{userName}}</td>
        </tr>
        {{endfor bitacoras}}
    </tbody>
</table>
{{else}}
<p>No tienes compras registradas.</p>
{{endif bitacoras}}

</section>
