<g:set var="haveResults" value="${searchResult}" />

<g:if test="${haveResults}">
<div class="row-fluid"><div class="span12">
  <g:each var="dato" in="${searchResult}" status="index">
  <g:set var="nombre" value="${dato.trayecto.toString()}" />
  <g:set var="infoId" value="${dato.trayecto.id}-${dato.fecha.time}" />
  <g:set var="link" value="${dato.url}" />
  <div class="row-fluid ${dato.fecha.format('dd-MM-yyyy')} ${dato.trayecto.destino.nombre.replace(' ', '-')}"><div class="span12">
    <div class="row-fluid">
      <div class="span1">
        <button type="button" class="btn btn-info btn-mini" style="margin-top: 10px;" data-toggle="collapse" data-target="#infotren${infoId}" id="buttonCollapse${infoId}">
          <i class="icon-minus"></i>
        </button>
      </div>
      <div class="span11 name"><h2><small><a href="${link}" target="_blank">${nombre} ${dato.fecha.format('EEEE dd/MM/yyyy')}</a></small></h2>
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
          });
        </script>
      </div>
    </div>
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