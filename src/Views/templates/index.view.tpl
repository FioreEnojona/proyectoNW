<section>
    <div>
        <h1>Bienvenidos a <strong>Dulce Encanto</strong></h1>
        <p>Deliciosas creaciones artesanales que endulzan cada momento especial de tu vida. Desde 1995, llevamos alegría
            y sabor a tus celebraciones con recetas tradicionales y un toque de innovación.</p>

    </div>
</section>

<section>
    <h1>Sobre Nuestra Pastelería</h1>
    <div>
        <article>
            <h2>Dulce Tradición</h2>
            <p>Más que una pastelería, somos un rincón donde los sabores de antaño se encuentran con la innovación. Cada
                producto que elaboramos lleva el sello de nuestra pasión por la repostería y el cuidado por los
                ingredientes de calidad.</p>
            <p>Desde hace más de 15 años, endulzamos los momentos especiales de nuestros clientes con creaciones únicas
                que despiertan emociones y crean recuerdos.</p>
        </article>
        <article>
            <h2>Contáctanos</h2>
            <p>Estamos aquí para atenderte y crear el postre perfecto para tu ocasión especial.</p>
            <address>
                <p>Teléfono: <a href="tel:+50412345678">+504 1234-5678</a></p>
                <p>Correo: <a href="mailto:contacto@pasteleria.com">contacto@pasteleria.com</a></p>
            </address>
        </article>
        <article>
            <h2>Visítanos</h2>
            <p>Estamos abiertos de Lunes a Viernes de 8:00 a.m a 4:00 p.m y los Sábados de 10:00 a.m a 3:00 p.m.</p>
            <p>Nuestra tienda está ubicada en el corazón de la ciudad, un espacio acogedor donde el aroma a pan recién
                horneado te da la bienvenida.</p>
            <address>
                <p>Calle Dulce, #123, Colonia Postres, Tegucigalpa</p>
            </address>
        </article>
    </div>
</section>

<section>
    <div>
        <h2>¿Por qué elegirnos?</h2>
        <p>En Dulce Encanto, cada creación es una obra maestra de sabor y dedicación. Descubre lo que nos hace
            diferentes en el mundo de la repostería fina.</p>

        <div>
            <article>
                <img src="public/imgs/url/Blog-2.png" alt="Ingredientes Frescos y Naturales">
                <h3>Ingredientes Frescos y Naturales</h3>
                <p>Seleccionamos cuidadosamente los mejores ingredientes de proveedores locales comprometidos con la
                    calidad. Nuestras frutas son siempre de temporada, los huevos provienen de granjas libres de jaulas,
                    y utilizamos mantequilla 100% natural sin aditivos. Rechazamos el uso de conservantes, colorantes
                    artificiales y sabores sintéticos, priorizando siempre lo natural.</p>
            </article>

            <article>
                <img src="public/imgs/url/tartas-y-pasteles.jpg" alt="Recetas Artesanales">
                <h3>Tradición Artesanal</h3>
                <p>Nuestras recetas son un legado familiar perfeccionado a lo largo de tres generaciones. Cada producto
                    es elaborado a mano con técnicas tradicionales combinadas con innovación moderna. Desde el amasado
                    hasta el decorado final, cada paso es supervisado por nuestros maestros pasteleros con más de 20
                    años de experiencia. La paciencia y el cuidado en cada detalle hacen la diferencia en cada bocado.
                </p>
            </article>

            <article>
                <img src="public/imgs/url/amor.jpg" alt="Hecho con Amor">
                <h3>Pasión en Cada Detalle</h3>
                <p>Más que un negocio, esto es nuestra pasión. Cada pastel, galleta o postre que creamos lleva una dosis
                    especial de amor y dedicación. Nos enorgullece ser parte de tus momentos especiales: bodas,
                    cumpleaños, aniversarios o simplemente esos días que merecen ser endulzados. Nuestro compromiso va
                    más allá del sabor; creamos experiencias memorables a través de la repostería.</p>
            </article>
        </div>
    </div>
</section>

<h1 >Menú</h1>
<form method="get" action="index.php?page=index#menuancla">
    <select name="categoriaId" onchange="this.form.submit()">
        <option value="0">Todas las Opciones</option>
        {{foreach categories}}
        <option value="{{categoriaId}}" {{selected_categoriaId}}>{{nombre}}</option>
        {{endfor categories}}
    </select>
</form>

<div class="product-list" class="menuancla">
  {{foreach products}}
  <div class="product" data-productId="{{productId}}">
    <img src="{{productImgUrl}}" alt="{{productName}}">
    <h2>{{productName}}</h2>
    <p>{{productDescription}}</p>
    <span class="price">{{productPrice}}</span>
    <span class="stock">Disponible {{productStock}}</span>
    <a href="index.php?page=Products-Detalle&productId={{productId}}" class="btn-detail">Ver Detalle</a>
    <form action="index.php?page=index#menuancla" method="post">
        <input type="hidden" name="productId" value="{{productId}}">
        <button type="submit" name="addToCart" class="add-to-cart">
          <i class="fa-solid fa-cart-plus"></i>Agregar al Carrito
        </button>
    </form>
  </div>
  {{endfor products}}
</div>
<section>
    <div>
        <h2>Nuestras Exquisitas Creaciones</h2>
        <p>Descubre nuestras especialidades más solicitadas, cada una con una historia única de sabor y textura.</p>

        <div>
            <article>
                <img src="public/imgs/url/fresa.jpg" alt="Pastel de Fresa">
                <div>
                    <h3>Pastel de Fresa Clásico</h3>
                    <p>Nuestro emblemático pastel de fresa combina capas esponjosas de bizcocho vainilla con fresas
                        frescas de cultivo local y crema batida casera. Un clásico reinventado que ha sido el favorito
                        de nuestros clientes por más de 15 años. Perfecto para celebraciones íntimas o eventos grandes.
                    </p>
                    <p>Precio: $450 - $1,200</p>

                </div>
            </article>

            <article>
                <img src="public/imgs/url/colec.jpg" alt="Cupcakes Surtidos">
                <div>
                    <h3>Colección de Cupcakes Premium</h3>
                    <p>Una selección gourmet que incluye: chocolate belga con ganache, vainilla tahití con frosting de
                        crema de mantequilla y frambuesa silvestre con corazón de coulis. Cada cupcake es una pequeña
                        obra de arte, decorada a mano con ingredientes de primera calidad. Ideal para regalos
                        corporativos o eventos especiales.</p>
                    <p>Precio: $320 la docena</p>

                </div>
            </article>

            <article>
                <img src="public/imgs/url/images.jpg" alt="Cheesecake de Frambuesa">
                <div>
                    <h3>Cheesecake de Frambuesa</h3>
                    <p>Nuestra versión del clásico cheesecake combina una base crujiente de galleta artesanal con un
                        suave relleno de queso crema y un generoso coulis de frambuesa silvestre. Lo que lo hace único
                        es nuestro toque secreto: un delicado aroma de vainilla de Madagascar y una pizca de cardamomo
                        que realza todos los sabores.</p>
                    <p>Precio: $380 - $850</p>

                </div>
            </article>
        </div>
    </div>
</section>

<section>
    <div>
        <h2>Historias Dulces de Nuestros Clientes</h2>
        <p>La satisfacción de nuestros clientes es nuestra mejor receta. Estas son algunas de las experiencias que han
            compartido con nosotros.</p>

        <div>
            <blockquote>
                <p>"El pastel de mi boda fue absolutamente increíble, no solo por su belleza impresionante que dejó a
                    todos boquiabiertos, sino por su sabor excepcional. Meses después de la boda, mis invitados seguían
                    preguntando dónde lo habíamos encargado. El equipo de Dulce Encanto entendió perfectamente nuestra
                    visión y la superó con creces, creando un pastel que fue el centro de atención de nuestra
                    recepción."</p>
                <footer>— Ana López, Novia feliz</footer>
            </blockquote>

            <blockquote>
                <p>"Como madre de tres niños con gustos muy diferentes, encontrar postres que satisfagan a todos era un
                    desafío... hasta que descubrimos Dulce Encanto. Mis hijos han desarrollado un paladar exigente y
                    ahora rechazan cupcakes de cualquier otro lugar. La calidad de los ingredientes y el equilibrio
                    perfecto de dulzura hacen que sus creaciones sean irresistibles. Hemos convertido la visita mensual
                    a su pastelería en una tradición familiar."</p>
                <footer>— Carlos Mendoza, Padre satisfecho</footer>
            </blockquote>

            <blockquote>
                <p>"Como organizadora de eventos, he trabajado con muchas pastelerías, pero Dulce Encanto se ha
                    convertido en mi proveedor exclusivo. Cada interacción con su equipo es una experiencia positiva:
                    desde la asesoría personalizada hasta la puntualidad en las entregas. Sus productos no solo son
                    visualmente impresionantes, sino que mantienen una calidad excepcional incluso cuando necesito
                    servir a 300 invitados. ¡Nunca decepcionan!"</p>
                <footer>— Paola Rodríguez, Event Planner</footer>
            </blockquote>
        </div>
    </div>
</section>

<section>
    <div>
        <h2>¡Dulces Noticias para Ti!</h2>
        <p>Únete a nuestra comunidad de amantes de la repostería fina y recibe contenido exclusivo directamente en tu
            bandeja de entrada:</p>

        <ul>
            <li>Descuentos especiales para suscriptores (15% en tu primer pedido)</li>
            <li>Recetas exclusivas de temporada</li>
            <li>Invitaciones a eventos y talleres</li>
            <li>Novedades de productos antes del lanzamiento</li>
        </ul>

        <form action="/suscribirse" method="POST">
            <label for="correo">Tu correo electrónico:</label>
            <input type="email" id="correo" name="correo" placeholder="Tu correo electrónico" required>
            <button type="submit">Suscribirme</button>
        </form>

        <p style="opacity: 0.7; font-size: 0.9rem;">Respetamos tu privacidad. Nunca compartiremos tu información.</p>
    </div>
</section>