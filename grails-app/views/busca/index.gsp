<!DOCTYPE HTML>
<%@ page defaultCodec="html" %>
<html lang="es" class="no-js">
  <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><g:if test="${params.q && params.q?.trim() != ''}">${params.q} - </g:if>Treneo</title>
    <link href='http://fonts.googleapis.com/css?family=Sue+Ellen+Francisco|Duru+Sans|Quicksand|Oleo+Script+Swash+Caps|Vast+Shadow|Smokum|Montserrat+Alternates|Shojumaru|Peralta|Prosto+One' rel='stylesheet' type='text/css'>
    <g:set var="colors" value="['#34a5aa', '#aaaaaa', '#4789aa', '#d3e310']"/>
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
    <div class="block block-search">
      <h1 class="treneo">Treneo</h1>
      <g:form url='[controller: "busca", action: "index"]' id="searchableForm" name="searchableForm" method="get" accept-charset="UTF-8">
          <p><input class="input-search" type="text" name="q" id="q" value="${params.q}" size="50" placeholder="Origen, destino (o destinos) y fechas ('${new Date().format('dd/MM/yyyy')}' o 'mañana' o 'agosto' o...)" autocomplete="off"/>
          <br/>
          <input type="submit" id="lq" class="btn large" value="Buscar" onclick=""/></p>
          <p>Un buscador de trenes sencillo y práctico</p>
      </g:form>
      <p class="meta"> 
        Por <a href="#">Víctor Simón</a> e <a href="#">Isabel Berruezo</a>
        <br/>
        Renfe puede que no, pero ¡treneo.es te necesita!
      </p>
      <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
        <input type="hidden" name="cmd" value="_s-xclick">
        <input type="hidden" name="hosted_button_id" value="7Z58KKP34ULTW">
        <input type="image" src="https://www.paypalobjects.com/es_ES/ES/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal. La forma rápida y segura de pagar en Internet.">
        <img alt="" border="0" src="https://www.paypalobjects.com/es_ES/i/scr/pixel.gif" width="1" height="1">
      </form>
    </div>
    <div class="block block-somos">
      <h2>somos un buscador de trenes</h2>
      <p>
      Treneo busca en Renfe la información de sus trenes: ave, alvia, altaria, etc. y de todas las estaciones, ya sean grandes: madrid, barcelona, sevilla, málaga, zaragoza, pamplona... o pequeñas: alcalá de xiver, barbera del valles...
      </p>
    </div>
    <div class="block block-informacion">
      <h2>damos información de renfe</h2>    
      <p>
      Proporcionamos información relevante para que planifiques tu viaje. De un solo vistazo puedes ver los distintos trenes para un trayecto, con sus horarios y precios, para uno o varios días.
      <br/>
      Y no nos quedamos ahí. Destacamos los mejores precios del día, filtramos la información por clase, horario, etc., enlazamos con la página de Renfe directamente para que puedas reservar sin dar vueltas tu billete; cuanto más práctica la información, mejor.
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
              <li><small><a href="${createLink(action:'index', params:[q:origen+' '+destino])}">Renfe ave alvia ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
            </g:each>
          </ul>
        </div>
        <div class="span4 columns">
          <g:set var="origen" value="barcelona"/>
          <g:set var="destinos" value="${['madrid','valencia','sevilla','málaga','bilbao','alicante','pamplona','zaragoza']}"/>
          <ul>
            <g:each var="destino" in="${destinos}">
              <li><small><a href="${createLink(action:'index', params:[q:origen+' '+destino])}">Renfe ave alvia ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
            </g:each>
          </ul>
        </div>
        <div class="span4 columns">
          <g:set var="origen" value="sevilla"/>
          <g:set var="destinos" value="${['madrid','barcelona','valencia','málaga','bilbao','alicante','pamplona','zaragoza']}"/>
          <ul>
            <g:each var="destino" in="${destinos}">
              <li><small><a href="${createLink(action:'index', params:[q:origen+' '+destino])}">Renfe ave alvia ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
            </g:each>
          </ul>
        </div>
      </div>
    </div>
    <div class="block block-footer">
      <p class="meta">
        Ponte en contacto con nosotros y siguenos
        <br/>
        <a href="">contacto@treneo.es</a>
      </p>
    </div>
    <script type="text/javascript">
      $(document).ready( function() {
        var fonts = ["Sue Ellen Francisco, cursive","Duru Sans, sans-serif","Quicksand, sans-serif","Oleo Script Swash Caps, cursive","Vast Shadow, cursive","Smokum, cursive","Montserrat Alternates, sans-serif","Shojumaru, cursive","Peralta, cursive","Prosto One, cursive","Kavoon, cursive","Bubbler One, sans-serif","Ceviche One, cursive","Ribeye Marrow, cursive"];

        $('.treneo').css('color', '${colors[(new java.util.Random()).nextInt(4)]}');
        $('.treneo').css('font-family', fonts[${(new java.util.Random()).nextInt(11)}]);
        /*
        var ePrincipales = [];
        var e = [];
        var fechas = ['2222','3333','4444'];
        for(var i = 0; i < estaciones.length; i++) {
          e.push(estaciones[i][0]);
        }
        for(var i = 0; i < estacionesPrincipales.length; i++) {
          ePrincipales.push(estacionesPrincipales[i][0]);
        }

        var extractor = function(query) {
          var result = /([^,]+)$/.exec(query);
          if(result && result[1])
            return result[1].trim();
          return '';
        }

        var updater = function(item) {
          var pre = item.length >= this.$element.val().length ? 'Desde ': ' hasta ';
          if (this.$element.val().search('hasta') != -1)
            pre = ' o hasta ';
          var txt = $('#lq').attr('value').replace(/[^ ]*$/,'')+pre+item+' ';
          $('#lq').attr('value', txt);
          return this.$element.val().replace(/[^ ]*$/,'')+item+', ';
        }

        var matcher = function (item) {
          var tquery = extractor(this.query);
          if(!tquery) return false;
          return ~item.toLowerCase().indexOf(tquery.toLowerCase());
        }

        var highlighter = function (item) {
          var query = extractor(this.query).replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
          return item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
            return '<strong>' + match + '</strong>'
          });
        }          

        var ta = $('#q').typeahead({
            source: ePrincipales,
            minLength: 0,
            items: 4,
            updater: updater,
            matcher: matcher,
            highlighter: highlighter
          });

        var setSource = function (source) {
          var v = $('#q').val();
          $('#q').data('typeahead').source = source;
          $('#q').val(v);
        }

        var setFechas = function() {
          setSource(fechas);
        }

        var setPrincipales = function() {
          setSource(ePrincipales);
        }

        var setTodas = function() {
          setSource(e);
        }

        $('#q').on('keydown', function(e) {
          if (e.keyCode >= 33 && e.keyCode <= 115) {
            if (e.keyCode > 31 && (e.keyCode >= 48 && e.keyCode <= 57)) {
              setFechas();
            } else {
              var lastSpace = $(this).val().search(/[^ ]*$/);
              var actualLength = $(this).val().length;
              if ((actualLength - lastSpace) < 3) {
                setPrincipales();
              } else {
                setTodas();
              }
            }
          }          
        });
        */
      });
    </script>
    <g:render template="/layouts/analitycstracking"/>
    <!-- Included Javascript files and other resources -->
    <r:layoutResources />
  </body>
</html>
