<section class="factura">
  <h1 class="factura_heading">Factura de Pago</h1>

  <div class="factura_info">
    <p><strong>ID de Transacción:</strong> {{id}}</p>
    <p><strong>Fecha de creación:</strong> {{create_time}}</p>
    <p><strong>Estado:</strong> {{status}}</p>
    <p><strong>Intento de pago:</strong> {{intent}}</p>
  </div>

  <div class="factura_pagador">
    <h2 class="factura_subheading">Datos del Comprador</h2>
    <p><strong>Nombre:</strong> {{nombre}}</p>
    <p><strong>Email:</strong> {{email}}</p>
    <p><strong>ID del Comprador:</strong> {{payer_id}}</p>
  </div>

  <div class="factura_detalle">
    <h2 class="factura_subheading">Detalle de la Compra</h2>
    <p><strong>Referencia:</strong> {{referencia}}</p>
    <p><strong>Moneda:</strong> {{moneda}}</p>
    <p><strong>Total:</strong> ${{total}}</p>
  </div>
  <div class="factura_footer">
    <button class="btn-regresar" onclick="window.location.href='index.php?page=Index'">Regresar</button>
  </div>
</section>
