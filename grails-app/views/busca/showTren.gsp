<g:if test="${trenes.size() > 0}">
<table class="table" style="font-size: 11px; width: 500px;">
  <tr><th>Salida</th><th>llegada</th><th>Precio</th><th>Tarifa</th></tr>
  <g:set var="lastHora" value=""/>
  <g:set var="precio" value="10000"/>
  <g:each var="tren" in="${trenes}" status="t">
    <g:if test="${tren.precio.toBigDecimal() <= precio.toBigDecimal() && tren.tarifa.codigo != 'GL544'}">
      <g:set var="precio" value="${tren.precio}" />
    </g:if>
    <tr>
      <td>
        <g:if test="${lastHora != tren.salida.format('HH:mm')}">
          ${tren.salida.format('HH:mm')}
        </g:if>
      </td>
      <td>
        <g:if test="${lastHora != tren.salida.format('HH:mm')}">
          ${tren.llegada.format('HH:mm')}
        </g:if>
      </td>
      <td class="${tren.precio.replace('.','_')} ${tren.tarifa.codigo}">${tren.precio}€</td>
      <td>${tren.tarifa.nombre} ${tren.clase.nombre}</td>
    </tr>
    <g:set var="lastHora" value="${tren.salida.format('HH:mm')}"/>
  </g:each>
  <script type="text/javascript">
    $(document).ready(function() {
      $('.${precio.replace('.','_')}').addClass('label label-success');
    });
  </script>
</table>
</g:if>
<g:else>
  NO DISPONIBLE
</g:else>
<script type="text/javascript">
  $(document).ready(function() {
    $('#infotren${infoId}').removeClass('loading');
  });
</script>
