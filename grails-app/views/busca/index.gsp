<%@ page defaultCodec="html" %>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><g:if test="${params.q && params.q?.trim() != ''}">${params.q} - </g:if>Trengle</title>
    <style type="text/css">
      .typeahead {
        text-align: left;
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

    <r:layoutResources />
    <script type="text/javascript" src="../js/jquery.suggest.js" ></script>
  </head>
  <body onload="focusQueryInput();">
    <div class="row-fluid">
        <div style="height: 231px;" class="span12">
          ${flash.message}
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
          <g:form class="form-horizontal" url='[controller: "busca", action: "index"]' id="searchableForm" name="searchableForm" method="get">
            <div class="row-fluid">
              <div class="span8 offset2">
                <input class="input text-left" style="width: 100%; height: 30px;" type="text" name="q" id="q" value="${params.q}" size="50" placeholder="Origen Destino Fecha" autocomplete="off"/> 
                <div class="row-fluid" style="margin-top: 10px;">            
                  <div class="span2 offset5">
                    <center>
                      <input type="submit" id="lq" class="btn" value="Buscar " />
                      <input type="hidden" name="max" value="5"/>
                    </center>
                  </div>
                </div>
              </div>
            </div>
          </g:form>
          <div id="kk"></div>
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
    <!-- Included Javascript files and other resources -->
    <r:layoutResources />
  </body>
</html>
