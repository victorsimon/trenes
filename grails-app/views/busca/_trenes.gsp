<g:set var="haveResults" value="${searchResult}" />

<g:if test="${haveResults}">
  <g:each var="dato" in="${searchResult}" status="index">
    <div class="row-fluid">
      <g:set var="nombre" value="${dato.trayecto.toString()}" />
      <g:set var="infoId" value="${dato.trayecto.id}-${dato.fecha.time}" />
      <g:set var="link" value="${dato.url}" />
      <div class="span6 name"><h2><small><a href="${link}" target="_blank">${nombre} ${dato.fecha.format('EEEE dd/MM/yyyy')}</a></small></h2></div>
    </div>
    <div class="row-fluid">
      <div id="infotren${infoId}" class="span6 loading">
        <g:formRemote id="form${infoId}" name="form${infoId}" update="infotren${infoId}" url="[action: 'showTren']" >
          <input type="hidden" name="trayecto" value="${dato.trayecto.id}" />
          <input type="hidden" name="fecha" value="${dato.fecha.format('dd/MM/yyyy')}" />
          <input type="hidden" name="infoId" value="${infoId}" />
        </g:formRemote>
        <script>
          $(document).ready(function() {
            $('#form${infoId}').submit();
          });
        </script>
      </div>
    </div>
  </g:each>
</g:if>
<g:else>
  No hay trayecto entre esas estaciones
</g:else>
<script type="text/javascript">
  $(document).ready(function() {
    $('#trenes').removeClass('loading');
  });
</script>