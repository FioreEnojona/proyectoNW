<section class="container-m row px-4 py-4">
  <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4">
  {{with product}}
  <form action="index.php?page=Products_Product&mode={{~mode}}&productId={{productId}}" method="POST" class="col-12 col-m-8 offset-m-2">
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productIdD">Código</label>
      <input class="col-12 col-m-9" readonly disabled type="text" name="productIdD" id="productIdD" placeholder="Código" value="{{productId}}" />
      <input type="hidden" name="mode" value="{{~mode}}" />
      <input type="hidden" name="productId" value="{{productId}}" />
      <input type="hidden" name="token" value="{{~product_xss_token}}" />
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productName">Producto</label>
      <input class="col-12 col-m-9" {{~readonly}} type="text" name="productName" id="productName" placeholder="Nombre del Producto" value="{{productName}}" />
      {{if productName_error}}
      <div class="col-12 col-m-9 offset-m-3 error">
        {{productName_error}}
      </div>
      {{endif productName_error}}
    </div>

   <div class="row my-2 align-center">
  <label class="col-12 col-m-3" for="categoriaId">Categoría</label>
  <select class="col-12 col-m-9" name="categoriaId" id="categoriaId" {{if ~readonly}} disabled {{endif ~readonly}} required>
    <option value="">-- Seleccione una categoría --</option>
    <option value="1" {{categoriaId_pastel}}>Pastel</option>
    <option value="2" {{categoriaId_cheesecake}}>Cheesecake</option>
    <option value="3" {{categoriaId_cupcake}}>Cupcake</option>
  </select>
  {{if categoriaId_error}}
  <div class="col-12 col-m-9 offset-m-3 error">
    {{categoriaId_error}}
  </div>
  {{endif categoriaId_error}}
</div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productDescription">Descripción</label>
      <textarea class="col-12 col-m-9" {{~readonly}} name="productDescription" id="productDescription" placeholder="Descripción del Producto">{{productDescription}}</textarea>
      {{if productDescription_error}}
      <div class="col-12 col-m-9 offset-m-3 error">
        {{productDescription_error}}
      </div>
      {{endif productDescription_error}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productPrice">Precio</label>
      <input class="col-12 col-m-9" {{~readonly}} type="number" name="productPrice" id="productPrice" placeholder="Precio del Producto" value="{{productPrice}}" />
      {{if productPrice_error}}
      <div class="col-12 col-m-9 offset-m-3 error">
        {{productPrice_error}}
      </div>
      {{endif productPrice_error}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productImgUrl">Url de Imágen (250 x 200)</label>
      <input class="col-12 col-m-9" {{~readonly}} type="text" name="productImgUrl" id="productImgUrl" placeholder="URL de la imagen" value="{{productImgUrl}}" />
      {{if productImgUrl_error}}
      <div class="col-12 col-m-9 offset-m-3 error">
        {{productImgUrl_error}}
      </div>
      {{endif productImgUrl_error}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productStatus">Estado</label>
      <select name="productStatus" id="productStatus" class="col-12 col-m-9" {{if ~readonly}} disabled {{endif ~readonly}}>
        <option value="ACT" {{productStatus_act}}>Activo</option>
        <option value="INA" {{productStatus_ina}}>Inactivo</option>
      </select>
    </div>
    
  {{endwith product}}

    <div class="row my-4 align-center flex-end">
      {{if showCommitBtn}}
      <button class="primary col-12 col-m-2" type="submit" name="btnConfirmar">Confirmar</button>
      &nbsp;
      {{endif showCommitBtn}}

      <button class="col-12 col-m-2" type="button" id="btnCancelar">
        {{if showCommitBtn}} Cancelar {{endif showCommitBtn}}
        {{ifnot showCommitBtn}} Regresar {{endifnot showCommitBtn}}
      </button>
    </div>
  </form>
</section>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const btnCancelar = document.getElementById("btnCancelar");
    btnCancelar.addEventListener("click", (e) => {
      e.preventDefault();
      e.stopPropagation();
      window.location.assign("index.php?page=Products_Products");
    });
  });
</script>