<section class="depth-2 px-2 py-2">
    <h2>{{modeDsc}}</h2>
</section>
<section class="grid py-4 px-4 my-4">
    <div class="row">
        <div class="col-12 offset-m-1 col-m-10 offset-l-3 col-l-6">
            <form class="row" action="index.php?page=Seguridad-Funcion&mode={{mode}}&fncod={{fncod}}" method="post">
                <div class="row">
                    <label for="fncod" class="col-12 col-m-4">ID</label>
                    <input readonly type="text" class="col-12 col-m-8" name="fncod" id="fncod" value="{{fncod}}" />
                    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
                </div>
                <div class="row">
                    <label for="fndsc" class="col-12 col-m-4">DSC</label>
                    <input type="text" class="col-12 col-m-8" name="fndsc" id="fndsc" value="{{fndsc}}" {{readonly}}/>
                    {{if error_fndsc}} 
                        <span class="error col-12 col-m-8">{{error_fndsc}}</span>
                    {{endif error_fndsc}}
                </div>
                <div class="row">
                    <label for="fnest" class="col-12 col-m-4">Estado</label>
                    <select id="fnest" name="fnest"  {{if readonly}}readonly disabled{{endif readonly}} >
                        <option value="ACT" {{estadoACT}}>Activo</option>
                        <option value="INA" {{estadoINA}}>Inactivo</option>
                        <option value="RTR" {{estadoRTR}}>Retirado</option>
                    </select>
                     {{if error_estado}} 
                        <span class="error col-12 col-m-8">{{error_estado}}</span>
                    {{endif error_estado}}
                </div>
                <div class="row">
                    <label for="fntyp" class="col-12 col-m-4">Tipo</label>
                    <input type="text" class="col-12 col-m-8" name="fntyp" id="fntyp" value="{{fnest}}" {{readonly}}/>
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
            window.location.assign("index.php?page=Seguridad-Funciones")
        });
    });
</script>
