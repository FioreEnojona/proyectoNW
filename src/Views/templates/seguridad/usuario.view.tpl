<section class="depth-2 px-2 py-2">
    <h2>{{modeDsc}}</h2>
</section>
<section class="grid py-4 px-4 my-4">
    <div class="row">
        <div class="col-12 offset-m-1 col-m-10 offset-l-3 col-l-6">
            <form class="row" action="index.php?page=Seguridad-Usuario&mode={{mode}}&id={{usercod}}" method="post">
                <div class="row">
                    <label for="usercod" class="col-12 col-m-4">ID</label>
                    <input readonly type="text" class="col-12 col-m-8" name="usercod" id="usercod" value="{{usercod}}" />
                    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
                </div>
                <div class="row">
                    <label for="useremail" class="col-12 col-m-4">Correo</label>
                    <input type="email" class="col-12 col-m-8" name="useremail" id="useremail" value="{{useremail}}" {{readonly}}/>
                    {{if error_useremail}} 
                        <span class="error col-12 col-m-8">{{error_useremail}}</span>
                    {{endif error_useremail}}
                </div>
                <div class="row">
                    <label for="username" class="col-12 col-m-4">Nombre</label>
                    <input type="text" class="col-12 col-m-8" name="username" id="username" value="{{username}}" {{readonly}}/>
                    {{if error_username}} 
                        <span class="error col-12 col-m-8">{{error_username}}</span>
                    {{endif error_username}}
                </div>
                <div class="row">
                    <label for="userpswd" class="col-12 col-m-4">Contraseña</label>
                    <input type="password" class="col-12 col-m-8" name="userpswd" id="userpswd" value="{{userpswd}}" {{readonly}}/>
                    {{if error_userpswd}} 
                        <span class="error col-12 col-m-8">{{error_userpswd}}</span>
                    {{endif error_userpswd}}
                </div>
                <div class="row">
                    <label for="userfching" class="col-12 col-m-4">Fecha de Creación</label>
                    <input type="datetime-local" class="col-12 col-m-8" name="userfching" id="userfching" value="{{userfching}}" {{readonly}}/>
                </div>
                <div class="row">
                    <label for="userpswdest" class="col-12 col-m-4">Estado</label>
                    <select id="userpswdest" name="userpswdest"  {{if readonly}}readonly disabled{{endif readonly}} >
                        <option value="ACT" {{estadoACT}}>Activo</option>
                        <option value="INA" {{estadoINA}}>Inactivo</option>
                        <option value="RTR" {{estadoRTR}}>Retirado</option>
                    </select>
                     {{if error_estado}} 
                        <span class="error col-12 col-m-8">{{error_estado}}</span>
                    {{endif error_estado}}
                </div>
                <div class="row">
                    <label for="userpswdexp" class="col-12 col-m-4">Expiración Contraseña</label>
                    <input type="datetime-local" class="col-12 col-m-8" name="userpswdexp" id="userpswdexp" value="{{userpswdexp}}" {{readonly}}/>
                </div>
                <div class="row">
                    <label for="userest" class="col-12 col-m-4">Estado Usuario</label>
                    <select name="userest" id="userest" {{readonly}}>
                        <option value="ACT" {{estadoACT}}>Activo</option>
                        <option value="INA" {{estadoINA}}>Inactivo</option>
                        <option value="RTR" {{estadoRTR}}>Retirado</option>
                    </select>
                </div>
                <div class="row">
                    <label for="useractcod" class="col-12 col-m-4">Código Activación</label>
                    <input type="text" class="col-12 col-m-8" name="useractcod" id="useractcod" value="{{useractcod}}" {{readonly}}/>
                </div>
                <div class="row">
                    <label for="userpswdchg" class="col-12 col-m-4">Última Modificación Contraseña</label>
                    <input type="datetime-local" class="col-12 col-m-8" name="userpswdchg" id="userpswdchg" value="{{userpswdchg}}" {{readonly}}/>
                </div>
                <div class="row">
                    <label for="usertipo" class="col-12 col-m-4">Tipo de Usuario</label>
                    <select name="usertipo" id="usertipo" {{readonly}}>
                        <option value="NOR" {{tipoNOR}}>Normal</option>
                        <option value="CON" {{tipoCON}}>Consultor</option>
                        <option value="CLI" {{tipoCLI}}>Cliente</option>
                    </select>
                </div>
                <div class="row flex-end">
                    <button id="btnCancel">
                        {{if showAction}}
                            Cancelar
                        {{endif showAction}}
                        {{ifnot showAction}}
                            Volver
                        {{endifnot showAction}}
                    </button>
                    &nbsp;
                    {{if showAction}}
                    <button class="primary">Confirmar</button>
                    {{endif showAction}}
                </div>
                {{if error_global}}
                    {{foreach error_global}}
                        <div class="error col-12 col-m-8">{{this}}</div>
                    {{endfor error_global}}
                {{endif error_global}}
            </form>
        </div>
    </div>
</section>
<script>
    document.addEventListener("DOMContentLoaded", ()=> {
        document.getElementById("btnCancel").addEventListener("click", (e)=> {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Seguridad-Usuarios")
        });
    });
</script>
