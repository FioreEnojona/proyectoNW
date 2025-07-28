<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{SITE_TITLE}}</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{BASE_DIR}}/public/css/appstyle.css" />
    <link rel="stylesheet" href="{{BASE_DIR}}/public/css/style.css" />

  <script src="https://kit.fontawesome.com/{{FONT_AWESOME_KIT}}.js" crossorigin="anonymous"></script>
  {{foreach SiteLinks}}
  <link rel="stylesheet" href="{{~BASE_DIR}}/{{this}}" />
  {{endfor SiteLinks}}
  {{foreach BeginScripts}}
  <script src="{{~BASE_DIR}}/{{this}}"></script>
  {{endfor BeginScripts}}
</head>

<body>
  <header>
    <input type="checkbox" class="menu_toggle" id="menu_toggle" />
    <label for="menu_toggle" class="menu_toggle_icon">
      <div class="hmb dgn pt-1"></div>
      <div class="hmb hrz"></div>
      <div class="hmb dgn pt-2"></div>
    </label>
    <h1>{{SITE_TITLE}}</h1>
    
    <nav id="menu">
      <ul>
        <li><a href="index.php?page={{PUBLIC_DEFAULT_CONTROLLER}}" class="nav-cta"><i class="fas fa-home"></i>&nbsp;Inicio</a></li>
        {{foreach PUBLIC_NAVIGATION}}
        <li><a href="{{nav_url}}" class="nav-ctb">{{nav_label}}</a></li>
        {{endfor PUBLIC_NAVIGATION}}
      </ul>
    </nav>

  </header>
  <main>
    {{{page_content}}}
  </main>
  <footer>
      <div class="footer-content">
      <a href="https://www.facebook.com/Jireth.da/" target="_blank" rel="noopener" class="footer-link">
        <i class="fab fa-facebook-square"></i> <span class="facebook-text">Facebook</span>
      </a>
      <span class="footer-separator">|</span>
      <span class="footer-contact">
        <i class="fas fa-phone-alt"></i> (+504) 2662-0171
      </span>
      <span class="footer-separator">|</span>
      <a href="mailto:info@jireth.com" class="footer-link">
        <i class="fas fa-envelope"></i> info@jireth.com
      </a>
      <span class="footer-separator">|</span>
      <span class="footer-location">
        <i class="fas fa-map-marker-alt"></i> Santa Rosa de Copán, Honduras, América Central.
      </span>
    </div>
    <div>Todo los Derechos Reservados {{~CURRENT_YEAR}} &copy;</div>
  </footer>
  {{foreach EndScripts}}
  <script src="{{~BASE_DIR}}/{{this}}"></script>
  {{endfor EndScripts}}
</body>

</html>
