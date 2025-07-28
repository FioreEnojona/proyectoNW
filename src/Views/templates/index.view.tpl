<h1>{{SITE_TITLE}}</h1>
<section class="about-section">
    <h1>Sobre Nuestra Pastelería</h1>
    <div class="about-cards">
        <div class="about-card about-info">
            <h2>Dulce Tradición</h2>
            <p>Más que una pastelería, somos un rincón donde los sabores de antaño se encuentran con la innovación. Cada producto que elaboramos lleva el sello de nuestra pasión por la repostería y el cuidado por los ingredientes de calidad.</p>
            <p>Desde hace más de 15 años, endulzamos los momentos especiales de nuestros clientes con creaciones únicas que despiertan emociones y crean recuerdos.</p>
        </div>
        <div class="about-card about-contact">
            <h2>Contáctanos</h2>
            <p>Estamos aquí para atenderte y crear el postre perfecto para tu ocasión especial.</p>
            <div class="contact-info">
                <i class="fas fa-phone"></i>
                <span>+504 1234-5678</span>
                <span>+504 1234-5678</span>
            </div>
            <div class="contact-info">
                <i class="fas fa-envelope"></i>
                <span>contacto@pasteleria.com</span>
                 <span>contacto@pasteleria.com</span>
            </div>
        </div>
        <div class="about-card about-location">
            <h2>Visítanos</h2>
            <p>Estamos abiertos de Lunes a Viernes de 8:00 a.m a 4:00 p.m y los Sabados de 10:00 p.m a 3:00 p.m</p>
            <p>Nuestra tienda está ubicada en el corazón de la ciudad, un espacio acogedor donde el aroma a pan recién horneado te da la bienvenida.</p>
            <div class="contact-info">
                <i class="fas fa-map-marker-alt"></i>
                <span>Calle Dulce, #123, Colonia Postres, Tegucigalpa</span>
            </div>
        </div>
    </div>
</section>

<h1>Menú</h1>
<form method="get" action="index.php?page=Index">
    <select name="categoriaId" onchange="this.form.submit()">
        <option value="0">Todas las Opciones</option>
        {{foreach categories}}
            <option value="{{categoriaId}}" {{selected_categoriaId}}>{{nombre}}</option>
        {{endfor categories}}
    </select>
</form>

<div class="product-list">
    {{foreach allProducts}}
    <div class="product" data-productId="{{productId}}">
        <img src="{{productImgUrl}}" alt="{{productName}}">
        <h2>{{productName}}</h2>
        <p>{{productDescription}}</p>
        <span class="price">L. {{productPrice}}</span>
        <button class="add-to-cart">Agregar al Carrito</button>
    </div>
    {{endfor allProducts}}
</div>
