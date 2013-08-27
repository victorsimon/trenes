<%@ page defaultCodec="html" %>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><g:if test="${params.q && params.q?.trim() != ''}">${params.q} - </g:if>Trengle</title>
    <style type="text/css">
      .container {
        margin-top: 20px;
      }
      .loading {
        background: url(../images/spinner.gif) 50% 50% no-repeat transparent;
        height: 16px;
        width: 16px;
        padding: 0.5em 20px;
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
  </head>
  <body onload="">
    <div class="container">
      <div class="row-fluid">
        <div class="span6">
          <g:form class="form-inline" url='[controller: "busca", action: "index"]' id="searchableForm" name="searchableForm" method="get">
            <div class="row-fluid">
              <div class="span10">
                <input type="text" name="q" class="span12" id="q" value="${params.q}" placeholder="Origen Destino Fecha" autocomplete="off"/> 
              </div>
              <div class="span2">
                <button type="submit" class="btn" id="lq">Buscar</button>
                <input type="hidden" name="max" value="5"/>
              </div>
            </div>
          </g:form>
        </div>
      </div>
      <g:if test="${flash.message}">
        <div class="row-fluid">
            <div class="span12">
              <spam class="label label-warning">${flash.message}</spam>
            </div>
        </div>
      </g:if>
      <div class="row-fluid">
        <div class="span12 loading" id="trenes">
        </div>
      </div>
    </div>
    <g:formRemote id="formTrenes" name="formTrenes" update="trenes" url="[action: 'trenes']" >
      <input type="hidden" name="origenes" value="${origenes}" />
      <input type="hidden" name="destinos" value="${destinos}" />
      <input type="hidden" name="fechas" value="${fechas}" />
    </g:formRemote>
    <script>
      $(document).ready(function() {
        $('#formTrenes').submit();
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
    <r:layoutResources />
  </body>
</html>
