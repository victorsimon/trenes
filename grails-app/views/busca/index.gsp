<!DOCTYPE HTML>
<%@ page defaultCodec="html" %>
<html lang="es" class="no-js">
  <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><g:if test="${params.q && params.q?.trim() != ''}">${params.q} - </g:if>Treneo</title>
    <link href='http://fonts.googleapis.com/css?family=Sue+Ellen+Francisco|Duru+Sans|Quicksand|Oleo+Script+Swash+Caps|Vast+Shadow|Smokum|Montserrat+Alternates|Shojumaru|Peralta|Prosto+One' rel='stylesheet' type='text/css'>
    <g:set var="colors" value="['#34a5aa', '#aaaaaa', '#4789aa', '#d3e310']"/>
    <style type="text/css">
      .typeahead {
        text-align: left;
      }
      .treneo {
        font-size: 92px;
        margin-bottom: 50px; 
        ${fonts[(new java.util.Random()).nextInt(11)]}
        color: ${colors[(new java.util.Random()).nextInt(4)]};
      }
    </style>
    <script type="text/javascript" src="http://www.renfe.com/js/estaciones.js" ></script>
    <script type="text/javascript">
        var focusQueryInput = function() {
            document.getElementById("q").focus();
        }
    </script>
    <r:require modules="jquery"/>
    <r:require modules="bootstrap"/>
    <script src="path/to/jquery.cookie.js"></script>
    <r:layoutResources />
    <script type="text/javascript" src="../js/jquery.suggest.js" ></script>
  </head>
  <body onload="focusQueryInput();">
    <div class="row-fluid">
        <div class="span12">
          <div style="height: 81px;" class="span12">
          </div>
          <center>
            <p class="treneo">Treneo</p>
          </center>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
          <g:form class="form-horizontal" url='[controller: "busca", action: "index"]' id="searchableForm" name="searchableForm" method="get" accept-charset="UTF-8">
            <div class="row-fluid">
              <div class="span8 offset2">
                <input class="input text-left" style="width: 100%; height: 30px;" type="text" name="q" id="q" value="${params.q}" size="50" placeholder="Origen, destino (o destinos) y fechas ('${new Date().format('dd/MM/yyyy')}' o 'mañana' o 'agosto' o...)" autocomplete="off"/> 
                <div class="row-fluid" style="margin-top: 10px;">            
                  <div class="span2 offset5">
                    <center>
                      <input type="submit" id="lq" class="btn" value="Buscar" onclick=""/>
                    </center>
                  </div>
                </div>
              </div>
            </div>
          </g:form>
        </div>
    </div>
    <div class="row-fluid">
      <div class="span8 offset2 text-center">
        <h3>¡Bienvenido!</h3>
        <h4>Treneo es un buscador de trenes.</h4>
        <h6>Si, como otros. El de la propia Renfe por ejemplo. Pero treneo ¡está orientado al usuario! Parece lógico, ¿no? Nosotros pensamos igual, y por eso hemos lanzado un buscador que te sea útil para ti.</h6>
        <h4 class="text-center">¿Quieres saber cómo? Interpretando lo que buscas.<h4>
        <br/>
        <div class="row-fluid">
          <div class="span6 alert-error">
            <h4>Te dejamos decidir los destinos que quieres consultar.</h4>
            <h5>Por que no siempre te importa donde ir, si no solo ir. Si introduces el nombre de mas de dos estaciones, nosotros te daremos la información de los trayectos entre tu origen y todas ellas.</h5>
            <h5>Por ejemplo, si sales de Madrid y buscas el mejor precio entre ir a Sevilla, Valladolid o Pamplona. Tu búsqueda sería:</h5><h5> 'madrid sevilla valladolid pamplona'</h5>
            <h5>¿Te gusta?</h5>
          </div>
          <div class="span6 alert-success">
            <h4>Solo dinos cuando, como nos lo digas es igual.</h4>
            <h5>Aunque no seamos capaces de entenderlo todo, hay cosas que si.</h5>
            <h5>Si quieres viajar hoy, pues dinos 'hoy'. Y si quieres ver los trenes de mañana, pues pon 'mañana'. Nosotros te entendemos.</h5>
            <h5>Prueba con 'próxima semana', 'mes que viene', 'agosto', 'esta semana', etc. Si no lo reconocemos, siempre puedes ponernos la fecha exacta (para hoy es '${new Date().format('dd/MM/yyyy')}')</h5>
          </div>
        </div>
      </div>
    </div>
    <div class="row-fluid">
      <div class="span4 columns">
        <g:set var="origen" value="madrid"/>
        <g:set var="destinos" value="${['barcelona','valencia','sevilla','málaga','bilbao','alicante','pamplona','zaragoza']}"/>
        <ul>
          <g:each var="destino" in="${destinos}">
            <li><small><a href="${createLink(action:'index', params:[q:origen+' '+destino])}">Tren ave alvia ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
          </g:each>
        </ul>
      </div>
      <div class="span4 columns">
        <g:set var="origen" value="barcelona"/>
        <g:set var="destinos" value="${['madrid','valencia','sevilla','málaga','bilbao','alicante','pamplona','zaragoza']}"/>
        <ul>
          <g:each var="destino" in="${destinos}">
            <li><small><a href="${createLink(action:'index', params:[q:origen+' '+destino])}">Tren ave alvia ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
          </g:each>
        </ul>
      </div>
      <div class="span4 columns">
        <g:set var="origen" value="sevilla"/>
        <g:set var="destinos" value="${['madrid','barcelona','valencia','málaga','bilbao','alicante','pamplona','zaragoza']}"/>
        <ul>
          <g:each var="destino" in="${destinos}">
            <li><small><a href="${createLink(action:'index', params:[q:origen+' '+destino])}">Tren ave alvia ${origen.capitalize()} ${destino.capitalize()}</a></small></li>
          </g:each>
        </ul>
      </div>
    </div>
    <script type="text/javascript">
      $(document).ready( function() {
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
