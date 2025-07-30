<h1>Factura</h1>

<p><strong>ID Transacción:</strong> {{id_transaccion}}</p>
<p><strong>Estado:</strong> {{estado}}</p>
<p><strong>Fecha:</strong> {{fecha}}</p>
<p><strong>Comprador:</strong> {{comprador}}</p>
<p><strong>Email:</strong> {{email}}</p>

<table border="1" cellpadding="5">
    <thead>
        <tr>
            <th>Producto</th>
            <th>Cantidad</th>
            <th>Precio</th>
            <th>Subtotal</th>
        </tr>
    </thead>
    <tbody>
        {{foreach productos}}
        <tr>
            <td>{{nombre}}</td>
            <td>{{cantidad}}</td>
            <td>{{precio}}</td>
            <td>{{subtotal}}</td>
        </tr>
        {{endfor productos}}
    </tbody>
</table>

<h3>Total: {{total}}</h3>

<div class="factura_footer">
    <button class="btn-regresar" onclick="window.location.href='index.php?page=Index'">Regresar</button>
  </div>
