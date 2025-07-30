<h1>Trabajar con Roles</h1>

<section class="grid">
  <div class="row">
    <form class="col-12 col-m-8" action="index.php" method="get">
      <div class="flex align-center">
        <div class="col-8 row">
          <input type="hidden" name="page" value="Roles_Roles">
          <label class="col-3" for="rolCode">Código</label>
          <input class="col-9" type="text" name="roleCode" id="roleCode" value="{{roleCode}}" />
          <label class="col-3" for="roleStatus">Estado</label>
          <select class="col-9" name="roleStatus" id="roleStatus">
            <option value="EMP" {{roleStatus_EMP}}>Todos</option>
            <option value="ACT" {{roleStatus_ACT}}>Activo</option>
            <option value="INA" {{roleStatus_INA}}>Inactivo</option>
          </select>
        </div>
        <div class="col-4 align-end">
          <button type="submit">Filtrar</button>
        </div>
      </div>
    </form>
  </div>
</section>

<section class="WWList">
  <table>
    <thead>
      <tr>
        <th>Código</th>
        <th>Descripción</th>
        <th>Estado</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>
      {{foreach roles}}
      <tr>
        <td>{{rolescod}}</td>
        <td>
          <p>{{rolesdsc}}</p>
        </td>
        <td class="center">{{rolStatusDsc}}</td>
        <td class="center">
          <a href="index.php?page=Roles-Rol&mode=UPD&rolescod={{rolescod}}">Editar</a>
          &nbsp;
          <a href="index.php?page=Roles-Rol&mode=DEL&rolescod={{rolescod}}">Eliminar</a>
          &nbsp;
          <a href="index.php?page=Roles_Rol&mode=INS">Nuevo</a>

        </td>
      </tr>
      {{endfor roles}}
    </tbody>
  </table>
  {{pagination}}
</section>
