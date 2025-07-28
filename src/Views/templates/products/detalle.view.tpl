<section class="container-m row px-4 py-4">
  <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4">
  {{with product}}
  <div class="col-12 col-m-8 offset-m-2 product-detail">
    <img src="{{productImgUrl}}" alt="{{productName}}" class="responsive-img" />
    <h2>{{productName}}</h2>
    <p><strong>Descripción:</strong> {{productDescription}}</p>
    <p><strong>Precio:</strong> L. {{productPrice}}</p>
    <p><strong>Estado:</strong> {{productStatus}}</p>
    <p><strong>Categoría:</strong> {{categoriaNombre}}</p>
    <hr>
    <p><strong>Ingredientes:</strong> {{productIngredients}}</p>
    <p><strong>Características:</strong> {{productFeatures}}</p>
    <p><strong>Presentación:</strong> {{productPresentation}}</p>
    <p><strong>Alérgenos:</strong> {{productAllergens}}</p>
    <p><strong>Recomendaciones:</strong> {{productRecommendation}}</p>
    <p><strong>Conservación:</strong> {{productStorage}}</p>
    <p><strong>Personalizable:</strong> {{productCustom}}</p>
  </div>
  {{endwith product}}

  <div class="row my-4 align-center flex-end">
    <!-- Botón Añadir al Carrito -->
    <form action="index.php?page=Cart_Add" method="POST" class="col-12 col-m-3">
      <input type="hidden" name="productId" value="{{productId}}">
      <button class="primary col-12" type="submit">Añadir al Carrito</button>
    </form>

    <!-- Botón Regresar -->
    <button class="col-12 col-m-2" type="button" id="btnRegresar">
      Regresar
    </button>
  </div>
</section>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const btnRegresar = document.getElementById("btnRegresar");
    btnRegresar.addEventListener("click", (e) => {
      e.preventDefault();
      window.location.assign("index.php?page=Index");
    });
  });
</script>
