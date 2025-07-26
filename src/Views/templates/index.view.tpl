<h1>{{SITE_TITLE}}</h1>
<h1>Menú Completo</h1>

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
