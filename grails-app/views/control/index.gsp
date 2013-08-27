<html>

<head>
	<title><g:message code="default.welcome.title" args="[meta(name:'app.name')]"/> </title>
	<meta name="layout" content="trenes" />
	<script type="text/javascript" src="http://www.renfe.com/js/estaciones.js" ></script>
</head>

<body>

	<section id="intro" class="first">
		<h1>Acciones administrativas</h1>
		<p>
			Panel de acciones administrativas de la p&aacute;gina como recopilar las estaciones o refrescar los datos extraidos de renfe.
		</p>
	</section>

	<section id="info">
		<div class="row-fluid">
	    	<div class="span4">
		    	<div class="center">
					<h3>Descargar estaciones</h3>
				</div>
				<p>Accede al site de Renfe para recopilar las estaciones de tren disponibles.
					<g:message code="${flash.message}" args="${flash.args}" default="${flash.default}"/>
				</p>
				<g:link class="btn btn-large btn-primary" action="descargarEstaciones"><g:message code="default.welcome.title" args="[meta(name:'app.name')]"/></g:link>
			</div>
	    	<div class="span4">
		    	<div class="center">
					<h3>Extraer trayectos</h3>
				</div>
				<p>Extrae los posibles trayectos para una estaci&oacute;n determinada.
				</p>
				<form controller="control" action="extraerTrayectos">
					<input type="text" name="estacionInput" id="estacionInput" autocomplete="off">
					<g:submitButton class="btn btn-large btn-primary" name="extraerTrayectos" value="Extraer"/>
				</form>
			</div>
	    	<div class="span4">
		    	<div class="center">
					<h3>Extraer todos los trayectos</h3>
				</div>
				<p>Extrae los posibles trayectos para una estaci&oacute;n determinada.
				</p>
				<form controller="control" action="extraerTodosTrayectos">
					<g:submitButton class="btn btn-large btn-primary" name="extraerTodosTrayectos" value="Extraer"/>
				</form>
<!-- 	                <li>Less 1.3</li> -->
			</div>
	    </div>
		<div class="row-fluid">
	    	<div class="span4">
		    	<div class="center">
					<h3>Estraer trenes dia/trayecto</h3>
				</div>
				<p>Accede al site de Renfe para recopilar los trenes disponibles para un trayecto, un día en concreto..
				</p>
				<form controller="control" action="extraerTrenesDisponiblesPorDia">
					<div class="control-group fieldcontain">
						<label for="fecha" class="control-label"><g:message code="control.fecha.label" default="Fecha" /></label>
						<bs:datePicker name="fecha" precision="day"  value="${new Date()}" noSelection="['': '']" />
					</div>	
					<div class="control-group fieldcontain">
						<label for="dias" class="control-label"><g:message code="control.dias.label" default="Número de dias" /></label>
						<div class="controls">
							<g:field type="number" name="dias" value="1"/>
						</div>
					</div>
					<div class="control-group fieldcontain">
						<label for="trayecto" class="control-label"><g:message code="control.trayecto.label" default="Fecha" /></label>
						<g:select name="trayecto" from="${trayectos}" optionKey="id" value=""/>
					</div>	
					<g:submitButton class="btn btn-large btn-primary" name="extraerTrenesDisponiblesPorDia" value="Extraer"/>
				</form>
			</div>
	    	<div class="span4">
		    	<div class="center">
					<h3>Estraer trenes dia</h3>
				</div>
				<p>Accede al site de Renfe para recopilar los trenes disponibles para todos los trayectos, un día en concreto..
				</p>
				<form controller="control" action="estraerTodosTrenesPorDia">
					<div class="control-group fieldcontain">
						<label for="fecha" class="control-label"><g:message code="control.fecha.label" default="Fecha" /></label>
						<bs:datePicker name="fecha" precision="day"  value="${new Date()}" noSelection="['': '']" />
					</div>	
					<div class="control-group fieldcontain">
						<label for="dias" class="control-label"><g:message code="control.dias.label" default="Número de dias" /></label>
						<div class="controls">
							<g:field type="number" name="dias" value="1"/>
						</div>
					</div>
					<g:submitButton class="btn btn-large btn-primary" name="estraerTodosTrenesPorDia" value="Extraer"/>
				</form>
			</div>
	    	<div class="span4">
		    	<div class="center">
					<h3></h3>
				</div>
				<p>
				</p>
				<form controller="control" action="extraerTodosTrayectos">
					<g:submitButton class="btn btn-large btn-primary" name="extraerTodosTrayectos" value="Extraer"/>
				</form>
<!-- 	                <li>Less 1.3</li> -->
			</div>
	    </div>
	</section>
	<script type="text/javascript">
		var esta = [];
		$(document).ready( function() {
			for(var i = 1; i < estacionesPrincipales.length; i++) {
				esta.push(estacionesPrincipales[i][0]);
			}
			$('#estacionInput').typeahead({
				source: esta
			});
		});
	</script>
</body>

</html>
