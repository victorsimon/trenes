<g:if test="${nojs == 'true'}">
  <!DOCTYPE HTML>
  <%@page sitemeshPreprocess="false"%>
  <html lang="es" class="no-js">
    <head>
    <link rel="canonical" />
      <meta http-equiv="content-type" content="text/html;charset=UTF-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Horario y precios de renfe ${origenes[0]} - ${destinos.join('-')}</title>
      <meta name="description" content="Listado con los trenes disponibles en renfe para ${origenes} - ${destinos} ave, alvi y talgo. Horarios y precios por categoría."/>
      <link href='http://fonts.googleapis.com/css?family=Sue+Ellen+Francisco|Duru+Sans|Quicksand|Oleo+Script+Swash+Caps|Vast+Shadow|Smokum|Montserrat+Alternates|Shojumaru|Peralta|Prosto+One|Special+Elite|Maven+Pro' rel='stylesheet' type='text/css'>
      <g:set var="colors" value="['#34a5aa', '#aaaaaa', '#4789aa', '#d3e310']"/>
      <script type="text/javascript" src="http://www.renfe.com/js/estaciones.js" ></script>
      <r:require modules="jquery"/>
      <r:require modules="bootstrap"/>
      <r:require modules="result"/>
      <r:require modules="jquery-extra"/>
      <r:layoutResources />
    </head>
  <body onload="">
      <div class="container">
      <div class="row-fluid">
        <div class="span7 offset1">
          <div class="row-fluid">
            <a href="${createLink(uri: '/')}" title="Busca en renfe tus billetes de ave, alvia, talgo...">
              <div class="span12 treneo">
                Treneo
              </div>
            </a>
          </div>
          <div class="row-fluid filtros">
            <div class="span12">
              <g:set var="hasDestinos" value="${destinos?.size() > 1}"/>
              <g:set var="hasFechas" value="${fechas?.size() > 1}"/>
              <div class="row-fluid">
                <div class="span3">
                  Filtrar por: <a href="#" data-toggle="tooltip" title="Puedes ocultar algunos datos del resultado de tu búsqueda usando los filtros. Si pulsas sobre alguna de las opciones, aparecerá un panel con los datos que se están mostrando. Al pulsar en alguno de esos datos, lo ocultarás y si vuelves a pulsar en el, volverás a mostrarlo. Y si pulsas sobre 'Cancelar filtros' volverás a mostrar todos los datos. ¡Prueba!"><i class=" icon-info-sign"></i></a>
                </div>
                <div class="span3 offset6 text-right">
                  <a rel="nofollow" title="Cancelar filtros" class="accordion-toggle btn-cancelar" data-toggle="collapse" data-parent="#accordion-clase" href="">
                    <span class="label">Cancelar filtros</span>
                  </a>
                </div>
              </div>
              <div class="accordion" id="accordion-clase">
                <div class="accordion-group">
                  <div class="accordion-heading">
                    <div class="row-fluid">
                      <g:if test="${hasDestinos}">
                        <div class="span3">
                          <a rel="nofollow" title="Filtrar por los distintos destinos de tren (madrid, valencia, barcelona, sevilla, bilbao)" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-clase" href="#filtro-destinos">
                            Destino 
                          </a>
                        </div>
                      </g:if>
                      <g:if test="${hasFechas}">
                        <div class="span3">
                          <a rel="nofollow" title="Filtrar por fechas" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-clase" href="#filtro-fechas">
                            Fecha 
                          </a>
                        </div>
                      </g:if>
                      <div class="span3">
                        <a rel="nofollow" title="Filtrar por clase de renfe: turista, preferente, litera, etc." class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-clase" href="#filtro-clase">
                          Clase 
                        </a>
                      </div>
                      <div class="span3">
                        <a rel="nofollow" title="Filtrar por horarios. Trenes antes de las doce y después." class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-clase" href="#filtro-hora">
                          Horas 
                        </a>
                      </div>
                    </div>
                  </div>
                  <div class="accordion-body collapse" id="filtro-destinos">
                    <div class="accordion-inner">
                      <g:each var="destino" in="${destinos}">
                        <button type="button" class="btn btn-mini btn-destino" data-toggle="button">${destino instanceof List?destino[0]: destino }</button>
                      </g:each>
                    </div>
                  </div>
                  <div class="accordion-body collapse" id="filtro-fechas">
                    <div class="accordion-inner">
                      <div class="row-fluid">
                        <div class="span6">
                          <div class="row-fluid">
                            <label class="span3">Lunes</label><label class="span3">Martes</label><label class="span3">Miércoles</label><label class="span3">Jueves</label>
                          </div>
                        </div>
                        <div class="span6" style="margin-left: 9px;">
                          <div class="row-fluid">
                            <label class="span3">Viernes</label><label class="span3">Sábado</label><label class="span3">Domingo</label><label class="span3"></label>
                          </div>
                        </div>
                      </div>
                      <div class="row-fluid">
                        <div class="span6">
                          <div class="row-fluid">
                            <g:each var="fecha" in="${fechas}" status="i">
                              <g:if test="${dow[i] == 6}">
                                </div></div>
                                <div class="span6" style="margin-left: 9px;"><div class="row-fluid">                                
                              </g:if>
                              <div class="span3 ${i == 0 || dow[i] % 7 == 2?'offset'+(dow[i]-2)*3:''}">
                                <button type="button" class="btn btn-small btn-fecha" data-toggle="button">${fecha}</button>
                              </div>
                              <g:if test="${dow[i] % 7 == 1}">
                                </div></div></div>
                                <div class="row-fluid"><div class="span6"><div class="row-fluid">
                              </g:if>
                            </g:each>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="accordion-body collapse" id="filtro-clase">
                    <div class="accordion-inner">
                      <g:each var="clase" in="${treneo.Clase.list()}">
                        <button type="button" class="btn btn-small btn-clase" data-toggle="button">${clase.nombre}</button>
                      </g:each>
                    </div>
                  </div>
                  <div class="accordion-body collapse" id="filtro-hora">
                    <div class="accordion-inner">
                      <button type="button" class="btn btn-small btn-manana" data-toggle="button">Antes de las 12:00</button>
                      <button type="button" class="btn btn-small btn-tarde" data-toggle="button">Después de las 12:00</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
</g:if>
    <g:set var="haveResults" value="${searchResult}" />

    <g:if test="${haveResults}">
    <div class="row-fluid"><div class="span12">
      <g:each var="dato" in="${searchResult}" status="index">
      <g:set var="nombre" value="${dato.trayecto.toString()}" />
      <g:set var="infoId" value="${dato.trayecto.id}-${dato.fecha.time}" />
      <g:set var="link" value="${dato.url}" />
      <div class="row-fluid ${dato.fecha.format('dd-MM-yyyy')} ${dato.trayecto.destino.nombre.replace(' ', '-')}"><div class="span12">
        <div class="row-fluid">
          <div class="span12 name"><h2><button type="button" class="btn btn-mini btn-info" style="line-height: 10px;" data-toggle="collapse" data-target="#infotren${infoId}" id="buttonCollapse${infoId}"><i class="icon-minus"></i></button> <small><a id="renfe${infoId}" href="${link}" target="_blank">${nombre} ${dato.fecha.format('EEEE dd/MM/yyyy')}</a></small></h2>
          </div>
        </div>
        <div class="row-fluid accordion-group">
          <div id="infotren${infoId}" class="span12 loading collapse in">
            <g:formRemote id="form${infoId}" name="form${infoId}" update="infotren${infoId}" url="[action: 'showTren']" >
              <input type="hidden" name="trayecto" value="${dato.trayecto.id}" />
              <input type="hidden" name="fecha" value="${dato.fecha.format('dd/MM/yyyy')}" />
              <input type="hidden" name="infoId" value="${infoId}" />
            </g:formRemote>
            <script>
              $(document).ready(function() {
                $('#form${infoId}').submit();
                $('#infotren${infoId}').on('shown', function() {
                  $('#buttonCollapse${infoId}').html('<i class="icon-minus"></i>');
                });
                $('#infotren${infoId}').on('hidden', function() {
                  $('#buttonCollapse${infoId}').html('<i class="icon-plus"></i>');
                });
                $('#infotren${infoId}').on('click', function() {
                  $('#renfe${infoId}')[0].click();
                });
              });
            </script>
          </div>
        </div>
        <a title="Enlace los trenes del día" href="${createLink(action: 'showTren', params: [trayecto: dato.trayecto.id, fecha: dato.fecha.format('dd/MM/yyyy'), fechas: fechas, nojs: 'true'])}" >
          Para ver los trenes Renfe ${nombre} desde un equipo antiguo sin javascript pincha aquí
        </a>        
      </div></div>
      </g:each>
    </div></div>
    </g:if>
    <g:else>
      No hay trayecto entre esas estaciones
    </g:else>
    <script type="text/javascript">
      $(document).ready(function() {
        $('#trenes').removeClass('loading');
      });
    </script>
<g:if test="${nojs == 'true'}">
      </div>
      <div class="span3 publi">
          <g:render template="/layouts/sense300x600"/>
      </div>
    </div>
    <iframe id="setcookie" src="https://venta.renfe.com/vol/index.do" style="display: none;">
    </iframe>
    <script>
      $(document).ready(function() {
        var fonts = ["Sue Ellen Francisco, cursive","Duru Sans, sans-serif","Quicksand, sans-serif","Oleo Script Swash Caps, cursive","Vast Shadow, cursive","Smokum, cursive","Montserrat Alternates, sans-serif","Shojumaru, cursive","Peralta, cursive","Prosto One, cursive","Kavoon, cursive","Bubbler One, sans-serif","Ceviche One, cursive","Ribeye Marrow, cursive"];

        $('.treneo').css('color', '${colors[(new java.util.Random()).nextInt(4)]}');
        $('.treneo').css('font-family', fonts[${(new java.util.Random()).nextInt(11)}]);
        $('#formTrenes').submit();
        $('.btn-clase').on('click', function() {
          var clase = $(this).text();
          clase = clase.replace(/ /g, '_');
          clase = clase.replace('.', '_');
          clase = '.' + clase
          if ($(this).hasClass('btn-inverse')) {
            $(clase).removeClass('hidden');
            $(this).removeClass('btn-inverse');
          } else {
            $(clase).addClass('hidden');
            $(this).addClass('btn-inverse');
          }
        });
        $('.btn-fecha').on('click', function() {
          var fecha = '.' + $(this).text();
          fecha = fecha.replace(/\//g, '-');
          if ($(this).hasClass('btn-inverse')) {
            $(fecha).removeClass('hidden');
            $(this).removeClass('btn-inverse');
          } else {
            $(fecha).addClass('hidden');
            $(this).addClass('btn-inverse');
          }
        });
        $('.btn-destino').on('click', function() {
          var destino = '.' + $(this).text();
          destino = destino.replace(/ /g, '-');
          if ($(this).hasClass('btn-inverse')) {
            $(destino).removeClass('hidden');
            $(this).removeClass('btn-inverse');
          } else {
            $(destino).addClass('hidden');
            $(this).addClass('btn-inverse');
          }
        });
        $('.btn-manana').on('click', function() {
          var hora = '.manana';
          if ($(this).hasClass('btn-inverse')) {
            $(hora).removeClass('hidden');
            $(this).removeClass('btn-inverse');
          } else {
            $(hora).addClass('hidden');
            $(this).addClass('btn-inverse');
          }
        });
        $('.btn-tarde').on('click', function() {
          var hora = '.tarde';
          if ($(this).hasClass('btn-inverse')) {
            $(hora).removeClass('hidden');
            $(this).removeClass('btn-inverse');
          } else {
            $(hora).addClass('hidden');
            $(this).addClass('btn-inverse');
          }
        });
        $('.btn-cancelar').on('click', function() {
          $('.btn-inverse').removeClass('active btn-inverse');
          $('.hidden').removeClass('hidden');
          $('.accordion-body.in').collapse('toggle');
        });
      });
      $('#setcookie').ready(function() {
        $('#setcookie').remove();
      });
    </script>
    <!-- Included Javascript files and other resources -->
    <script type="text/javascript">
/*    
      var ePrincipales = [];
      var e = [];
      $(document).ready( function() {
        for(var i = 0; i < estaciones.length; i++) {
          e.push(estaciones[i][0]);
        }
        for(var i = 0; i < estacionesPrincipales.length; i++) {
          ePrincipales.push(estacionesPrincipales[i][0]);
        }

        $('#q').on('keydown', function(e) {
        });

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
        $('#q').typeahead({
          source: ePrincipales,
          minLength: 0,
          items: 1,
          updater: updater,
          matcher: matcher,
          highlighter: highlighter          
        });

        $('#q').typeahead({
          source: e,
          minLength: 3,
          items: 1,
          updater: updater,
          matcher: matcher,
          highlighter: highlighter          
        });

        focusQueryInput();
      });
*/
    </script>
    <g:render template="/layouts/analitycstracking"/>
    <r:layoutResources />
  </body>
</html>
</g:if>