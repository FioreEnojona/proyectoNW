<h1>{{SITE_TITLE}}</h1>
 <h1>Menú Completo</h1>
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