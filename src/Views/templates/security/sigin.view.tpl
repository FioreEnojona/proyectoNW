<section class="fullCenter">
  <form class="grid form-register" method="post" action="index.php?page=sec_register">
  <form class="grid" method="post" action="index.php?page=sec_register">
    <section class="depth-1 row col-12 col-m-8 offset-m-2 col-xl-6 offset-xl-3">
      <h1 class="col-12">Crea tu cuenta</h1>
    </section>
    <section class="depth-1 py-5 row col-12 col-m-8 offset-m-2 col-xl-6 offset-xl-3">

      
      <div class="row">
        <label class="col-12 col-m-4 flex align-center" for="txtName">Nombre</label>
        <div class="col-12 col-m-8">
          <input class="width-full" type="text" id="txtName" name="txtName" value="{{txtName}}" />
        </div>
        {{if errorName}}
        <div class="error col-12 py-2 col-m-8 offset-m-4">{{errorName}}</div>
        {{endif errorName}}
      </div>


      <div class="row">
        <label class="col-12 col-m-4 flex align-center" for="txtEmail">Correo Electrónico</label>
        <div class="col-12 col-m-8">
          <input class="width-full" type="email" id="txtEmail" name="txtEmail" value="{{txtEmail}}" />
        </div>
        <div class="error col-12 py-2 col-m-8 offset-m-4">{{errorEmail}}</div>
        {{endif errorEmail}}
      </div>

      <div class="row">
        <label class="col-12 col-m-4 flex align-center" for="txtConfirmarEmail">Confirmar Correo Electrónico</label>
        <div class="col-12 col-m-8">
          <input class="width-full" type="email" id="txtConfirmarEmail" name="txtConfirmarEmail" value="{{txtConfirmarEmail}}" />
        </div>
        {{if errorConfirmarEmail}}
        <div class="error col-12 py-2 col-m-8 offset-m-4">{{errorConfirmarEmail}}</div>
        {{endif errorConfirmarEmail}}
      </div>


      <div class="row">
        <label class="col-12 col-m-4 flex align-center" for="txtPswd">Contraseña</label>
        <div class="col-12 col-m-8">
          <input class="width-full" type="password" id="txtPswd" name="txtPswd" value="{{txtPswd}}" />
        </div>
        <div class="error col-12 py-2 col-m-8 offset-m-4">{{errorPswd}}</div>
        {{endif errorPswd}}
      </div>
      
      <div class="row">
        <label class="col-12 col-m-4 flex align-center" for="txtConfirmarPswd">Confirmar Contraseña</label>
        <div class="col-12 col-m-8">
          <input class="width-full" type="password" id="txtConfirmarPswd" name="txtConfirmarPswd" value="{{txtConfirmarPswd}}" />
        </div>
        {{if errorConfirmarPswd}}
        <div class="error col-12 py-2 col-m-8 offset-m-4">{{errorConfirmarPswd}}</div>
        {{endif errorConfirmarPswd}}
      </div>
      <div class="row right flex-end px-4">
        <button class="primary" id="btnSignin" type="submit">Crear Cuenta</button>
      </div>
        <div class="row right flex-end px-4 py-4">
          <a href="index.php?page=sec_login">¿Tienes una cuenta? Iniciar Sesión</a>
        </div>
    </section>
  </form>
</section>