<g:if test="${nojs == 'true'}">
  <!DOCTYPE HTML>
  <%@page sitemeshPreprocess="false"%>
  <html lang="es" class="no-js">
    <head>
      <title>Tren ${trenes[0]?.trayecto} salida ${trenes[0]?.salida.format('dd/MM/yyyy HH:mm')} Treneo</title>
      <meta http-equiv="content-type" content="text/html;charset=UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <script type="text/javascript" src="http://www.renfe.com/js/estaciones.js" ></script>
      <r:require modules="jquery"/>
      <r:require modules="bootstrap"/>
      <r:layoutResources />
    </head>
  <body onload="">
	<h1>Tren ${trenes[0]?.trayecto} salida ${trenes[0]?.salida.format('dd/MM/yyyy HH:mm')}</h1>
</g:if>
<g:if test="${trenes.size() > 0}">
<table class="table table-condensed" style="font-size: 10px;">
  <thead>
    <tr><th></th><th>Salida</th><th>llegada</th><th>Precio</th><th>Tarifa</th></tr>
  </thead>
  <g:set var="lastHora" value=""/>
  <g:set var="precio" value="10000"/>
  <g:each var="tren" in="${trenes}" status="t">
    <g:if test="${tren.precio.toBigDecimal() <= precio.toBigDecimal() && tren.tarifa.codigo != 'GL544'}">
      <g:set var="precio" value="${tren.precio}" />
    </g:if>
    <tr class="${tren.precio.replace('.','_')}_${infoId} ${tren.tarifa.codigo} ${tren.clase.nombre.replace(' ', '_').replace('.', '_')} ${tren.salida.format('HHmm').toInteger() > 1200?'tarde': 'manana'}">
      <td>
        <g:if test="${lastHora != tren.tren.tipo + '-' + tren.tren.numero + tren.salida.format('HH:mm')}">
          ${tren.tren.tipo}-${tren.tren.numero}</td>
        </g:if>
      <td>
        <g:if test="${lastHora != tren.tren.tipo + '-' + tren.tren.numero + tren.salida.format('HH:mm')}">
          ${tren.salida.format('HH:mm')}
        </g:if>
      </td>
      <td>
        <g:if test="${lastHora != tren.tren.tipo + '-' + tren.tren.numero + tren.salida.format('HH:mm')}">
          ${tren.llegada.format('HH:mm')}
        </g:if>
      </td>
      <td>${tren.precio}€</td>
      <td>${tren.tarifa.nombre} ${tren.clase.nombre}</td>
    </tr>
    <g:set var="lastHora" value="${tren.tren.tipo + '-' + tren.tren.numero + tren.salida.format('HH:mm')}"/>
  </g:each>
  <script type="text/javascript">
    $(document).ready(function() {
      $('.${precio.replace('.','_')}_${infoId}').addClass('success');
      $('.GL544').removeClass('success');
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
<g:if test="${nojs == 'true'}">
    <g:render template="/layouts/analitycstracking"/>
    <r:layoutResources />
  </body>
</html>
</g:if>
