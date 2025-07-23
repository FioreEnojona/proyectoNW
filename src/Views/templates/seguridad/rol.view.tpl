<section class="depth-2 px-2 py-2">
    <h2>{{modeDsc}}</h2>
</section>
<section class="grid py-4 px-4 my-4">
    <div class="row">
        <div class="col-12 offset-m-1 col-m-10 offset-l-3 col-l-6">
            <form class="row" action="index.php?page=Seguridad-Rol&mode={{mode}}&rolescod={{rolescod}}" method="post">
                <div class="row">
                    <label for="rolescod" class="col-12 col-m-4">ID</label>
                    <input readonly type="text" class="col-12 col-m-8" name="rolescod" id="rolescod" value="{{rolescod}}" />
                    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
                </div>
                <div class="row">
                    <label for="rolesdsc" class="col-12 col-m-4">DSC</label>
                    <input type="text" class="col-12 col-m-8" name="rolesdsc" id="rolesdsc" value="{{rolesdsc}}" {{readonly}}/>
                    {{if error_rolesdsc}} 
                        <span class="error col-12 col-m-8">{{error_rolesdsc}}</span>
                    {{endif error_rolesdsc}}
                </div>
                <div class="row">
                    <label for="rolesest" class="col-12 col-m-4">Estado</label>
                    <select id="rolesest" name="rolesest"  {{if readonly}}readonly disabled{{endif readonly}} >
                        <option value="ACT" {{estadoACT}}>Activo</option>
                        <option value="INA" {{estadoINA}}>Inactivo</option>
                        <option value="RTR" {{estadoRTR}}>Retirado</option>
                    </select>
                     {{if error_estado}} 
                        <span class="error col-12 col-m-8">{{error_estado}}</span>
                    {{endif error_estado}}
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
            window.location.assign("index.php?page=Seguridad-Roles")
        });
    });
</script>
