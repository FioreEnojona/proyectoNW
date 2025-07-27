<h2>Generador de WW para tablas</h2>
<ul>
    {{foreach tables}}
    <form action="index.php?page=Generator_Generator" method="post">
        <input type="hidden" name="table" value="{{name}}">
        <input type="submit" value="Generar WW para {{name}}">
    </form>
    {{endfor tables}}
</ul>

{{if columns}}
<h3>Columnas de la tabla{{table}}</h3>
<ul>
    {{foreach columns}}
    <li>{{$Field}}{{Type}} {{Null}} {{Key}} </li>
    {{endfor columns}}
</ul>
{{endif columns}}

<hr />


<div>
    <h3>DAO</h3>
    <pre>
    {{genResult}}

</pre>
    <h3>Controller</h3>
    <pre>
    {{genController}}
</pre>
    <h3>Simple Controller</h3>
    <pre>
    {{genSimpleController}}
</pre>

    <h3>Form</h3>
    <pre>
    {{genForm}}
</pre>
    <h3>Lista</h3>
    <pre>
    {{genList}}

</pre>

</div>