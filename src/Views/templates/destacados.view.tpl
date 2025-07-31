<h1>Ofertas del Día</h1>
<div class="product-list">
    {{foreach productsOnSale}}
    <div class="product" data-productId="{{productId}}">
        <img src="{{productImgUrl}}" alt="{{productName}}" width="200" height="200">
        <h2>{{productName}}</h2>
        
        <div class="price-info">
            <span class="old-price">Antes: {{productRegularPrice}}</span>
            <span class="current-price">Ahora: {{productPrice}} ({{productDiscount}}% OFF)</span>
        </div>
        <div class="stock-info">
            <span>Disponibles: {{productStock}}</span>
            <span class="sale-end">Oferta válida hasta: {{saleEnd}}</span>
        </div>
        <button class="add-to-cart">Agregar al Carrito</button>
        <button class="view-details">Ver Detalles</button>
    </div>
    {{endfor productsOnSale}}
</div>

<h1>Novedades</h1>
<div class="product-list">
    {{foreach productsNew}}
    <div class="product" data-productId="{{productId}}">
        <img src="{{productImgUrl}}" alt="{{productName}}">
        <h2>{{productName}}</h2>
        <p>{{productDescription}}</p>
        <span class="price">{{productPrice}}</span>
        <button class="add-to-cart">Agregar al Carrito</button>
    </div>
    {{endfor productsNew}}
</div>