<!DOCTYPE HTML>
<%@ page defaultCodec="html" %>
<html lang="es" class="no-js">
  <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Horarios y precios de Renfe, a cualquier destino - Treneo</title>
    <meta name="description" content="Busca de forma sencilla tu billete de Renfe para todos los trenes y trayectos, como renfe ave madrid barcelona, renfe ave madrid sevilla, etc o cercanias madrid. Consulta horarios y precios, y accede directamente á su página de compra."/>

    <meta property="og:title" content="Horarios y precios de Renfe, a cualquier destino - Treneo">
    <meta property="og:description" content="Busca de forma sencilla tu billete de Renfe para todos los trenes y trayectos, como renfe ave madrid barcelona, renfe ave madrid sevilla, etc o cercanias madrid. Consulta horarios y precios, y accede directamente á su página de compra.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="http://www.treneo.es/">
    <meta property="og:image" content="http://www.treneo.es/${resource(dir: 'images', file: 'logo-32x32.png')}">
    <meta property="og:site_name" content="Treneo">
    <meta property="fb:admins" content="10150538136194100,10200814374700791">

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'logo-16x16.png')}" type="image/x-icon">
    <link href='http://fonts.googleapis.com/css?family=Sue+Ellen+Francisco|Duru+Sans|Quicksand|Oleo+Script+Swash+Caps|Vast+Shadow|Smokum|Montserrat+Alternates|Shojumaru|Peralta|Prosto+One|Special+Elite|Maven+Pro' rel='stylesheet' type='text/css'>
    <script type="text/javascript" src="http://www.renfe.com/js/estaciones.js" ></script>
    <r:require modules="jquery"/>
    <r:require modules="bootstrap"/>
    <r:require modules="index"/>
    <r:layoutResources />
    <script type="text/javascript">
        var focusQueryInput = function() {
            document.getElementById("q").focus();
        }
    </script>
  </head>
  <body onload="focusQueryInput();">
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- Horizontal treneo -->
<ins class="adsbygoogle"
     style="display:inline-block;width:728px;height:90px"
     data-ad-client="ca-pub-8089105942108480"
     data-ad-slot="7690702097"></ins>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script>
    <div class="block block-search">
      <h1 class="treneo">Treneo</h1>
      <g:form url='[controller: "busca", action: "index"]' id="searchableForm" name="searchableForm" method="get" accept-charset="UTF-8">
          <p><input class="input-search" type="text" name="q" id="q" value="${params.q}" size="50" placeholder="Origen, destino (o destinos) y fechas ('${new Date().format('dd/MM/yyyy')}' o 'mañana' o 'agosto' o...)" autocomplete="off"/>
          <br/>
          <!--[if lt IE 9]>
            <p style="margin: -40px auto -15px;"><small style="font-size: 12px;">Origen, destino (o destinos) y fechas ('${new Date().format('dd/MM/yyyy')}' o 'mañana' o 'agosto' o...)</small></p>
            <br/>
          <![endif]-->
          <input type="submit" class="btn large" value="Buscar" onclick=""/></p>
          <p>Un buscador de trenes sencillo y práctico</p>
          <input id="lq" class="hidden" type="text" value=""/>
      </g:form>
      <p class="meta"> 
        Por <a rel="nofollow" title="Linkedin de Víctor Simón Batanero" href="http://es.linkedin.com/in/victorsimon">Víctor Simón</a> e <a rel="nofollow" title="Linkedin de Isabel Berruezo Aldunate" href="http://es.linkedin.com/in/ixabel">Isabel Berruezo</a>
        <br/>
        <br/>
        <p class="meta"><spam class="renfe">Renfe</spam> puede que no, pero ¡treneo.es te necesita!</p>
      </p>
      <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
        <input type="hidden" name="cmd" value="_s-xclick">
        <input type="hidden" name="hosted_button_id" value="7Z58KKP34ULTW">
        <input type="image" src="https://www.paypalobjects.com/es_ES/ES/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal. La forma rápida y segura de pagar en Internet.">
        <img alt="Dona a treneo.es busca trenes en renfe. Ave, alvia, madrid, valencia, renfecercanias madrid." border="0" src="https://www.paypalobjects.com/es_ES/i/scr/pixel.gif" width="1" height="1">
      </form>
          <div>
            <div class="fb-like" data-href="https://www.facebook.com/treneo" data-colorscheme="light" data-layout="button_count" data-action="like" data-show-faces="true"></div>
            <!-- Inserta esta etiqueta donde quieras que aparezca Botón +1. -->
            <div style="display: inline-block; margin-left: 30px;">
              <div class="g-plusone" data-href="https://plus.google.com/+TreneoEs" data-size="medium"></div>
            </div>
            <div class="g-ytsubscribe" data-channel="TreneoEs" data-layout="default"></div>
          </div>
      <div class="down-arrow">
        <h3 class="meta">descubre más</h3>
        <img alt="Lee más sobre treneo.es, y busca tus trenes en Rrenfe para renfe ave madrid barcelona sevilla valencia cercanias madrid." src="${resource(dir: 'images', file: 'down.jpg')}"/>
      </div>
    </div>
    <div class="block block-somos">
      <h2>horarios de renfe</h2>
      <p>
      Treneo busca en <spam class="renfe">Renfe</spam> la información de sus trenes: ave, alvia, altaria, etc. y de todas las estaciones, ya sean grandes: madrid, barcelona, sevilla, málaga, zaragoza, pamplona... o pequeñas: alcalá de xiver, barbera del valles...
      </p>
    </div>
    <div class="block block-informacion">
      <h2>damos información de <spam class="renfe">renfe</spam></h2>    
      <p>
      Proporcionamos información relevante para que planifiques tu viaje. De un solo vistazo puedes ver los distintos trenes para un trayecto, con sus horarios y precios, para uno o varios días.
      <br/>
      Y no nos quedamos ahí. Destacamos los mejores precios del día, filtramos la información por clase, horario, etc., enlazamos con la página de <spam class="renfe">Renfe</spam> directamente para que puedas reservar sin dar vueltas tu billete; cuanto más práctica la información, mejor.
      </p>
    </div>
    <div class="block block-prueba">
      <h2>opciones de búsqueda</h2>
      <p>
      Por ejemplo, si sales de Madrid y buscas el mejor precio entre ir a Sevilla, Valladolid o Pamplona. Tu búsqueda sería:
      <br/>
      <code>'madrid sevilla valladolid pamplona'</code>
      <br/>
      Si quieres viajar hoy, pues dinos <code>'hoy'</code>
      <br/>
      Y si quieres ver los trenes de mañana, pues pon <code>'mañana'</code>
      <br/>
      Prueba con <code>'próxima semana'</code>, <code>'mes que viene'</code>, <code>'agosto'</code>, <code>'esta semana'</code>
      <br/>
      Y siempre puedes ponernos la fecha exacta, para hoy es <code>'${new Date().format('dd/MM/yyyy')}'</code>
      </p>
    </div>
    <div class="block block-consulta">
      <h2>consulta directa</h2>
      <br/>
      <div class="row-fluid">
        <div class="span4 columns">
          <g:set var="origen" value="madrid"/>
          <g:set var="destinos" value="${['barcelona','valencia','sevilla','málaga','bilbao','alicante','pamplona','zaragoza']}"/>
          <ul>
            <g:each var="destino" in="${destinos}">
              <li><small><a title="Horarios Renfe ave ${origen.capitalize()} ${destino.capitalize()} próximos tres días" href="${createLink(uri:'/renfe/' + origen + '/' + destino)}">Horarios <spam class="renfe">Renfe</spam> ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
            </g:each>
          </ul>
        </div>
        <div class="span4 columns">
          <g:set var="origen" value="barcelona"/>
          <g:set var="destinos" value="${['madrid','valencia','sevilla','málaga','bilbao','alicante','pamplona','zaragoza']}"/>
          <ul>
            <g:each var="destino" in="${destinos}">
              <li><small><a title="Horarios Renfe ave ${origen.capitalize()} ${destino.capitalize()} próximos tres días" href="${createLink(uri:'/renfe/' + origen + '/' + destino)}">Horarios <spam class="renfe">Renfe</spam> ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
            </g:each>
          </ul>
        </div>
        <div class="span4 columns">
          <g:set var="origen" value="sevilla"/>
          <g:set var="destinos" value="${['madrid','barcelona','valencia','málaga','bilbao','alicante','pamplona','zaragoza']}"/>
          <ul>
            <g:each var="destino" in="${destinos}">
              <li><small><a title="Horarios Renfe ave ${origen.capitalize()} ${destino.capitalize()} próximos tres días" href="${createLink(uri:'/renfe/' + origen + '/' + destino)}">Horarios <spam class="renfe">Renfe</spam> ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
            </g:each>
          </ul>
        </div>
      </div>
    </div>
    <div class="block block-footer">
      <p class="meta">
        Ponte en contacto con nosotros y siguenos
        <br/>
        <a title="Email de contacto" rel="nofollow" href="mailto:contacto@treneo.es">contacto@treneo.es</a>
      </p>
    </div>
    <script type="text/javascript">
      $(document).ready( function() {
        treneoFontsAndColors();
        typeahead("${createLink(uri: '/query')}");        
      });
    </script>
    <g:render template="/layouts/analitycstracking"/>
    <!-- Included Javascript files and other resources -->
    <r:layoutResources />
    <div id="fb-root"></div>
    <script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/es_ES/all.js#xfbml=1";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
    <!-- Inserta esta etiqueta después de la última etiqueta de Botón +1. -->
    <script type="text/javascript">
      window.___gcfg = {lang: 'es'};

      (function() {
        var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
        po.src = 'https://apis.google.com/js/plusone.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
      })();
    </script>

    <script src="https://apis.google.com/js/plusone.js"></script>

  </body>
</html>
