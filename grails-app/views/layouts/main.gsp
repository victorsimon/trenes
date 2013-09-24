<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="es" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="es" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="es" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="es" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="es" class="no-js"><!--<![endif]-->
	<head>
		<title><g:layoutTitle default="Compartir Mesa De Tren - CMDT"/></title>
		<meta name="keywords" content="renfe, ferrocarril, tren, transporte, billete, billete internet, billete impreso, billete electrónico, venta de billetes, viaje tren, horario tren, horarios tren, viajar tren, viajero, reserva billete, cercanias, regionales, media distancia, ave, mercancias, vagones, talgo, alaris, altaria, alvia, arco, viajeros, compartir Tarifa Mesa, Tarifa mesa, renfe en, renfe renfe, renfe tren">
		<meta name="description" content="Desde compartir mesa de tren accede a descuentos en tus viajes en tren y benefíciate de la tarifa mesa de Renfe. Viaja barato en AVE, ALVIA y AVANT."/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="chrome=1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<meta name="HandheldFriendly" content="true">
		<meta name="MobileOptimized" content="width">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
		<meta property="og:title" content="CompartirMesaDeTren"/>
		<meta property="og:image" content="${resource(dir: 'images', file: 'cmdt_logo.png')}"/>
		<meta property="og:description" content="Compartir mesa de tren en ave y alvia"/>
		<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'cmdt_logo.png')}" type="image/x-icon">
		<link rel="StyleSheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css" media="screen">
		<link rel="StyleSheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css" media="screen">
		<g:layoutHead/>
		<g:javascript library="jquery" />
		<g:javascript library="jquery-ui" />
		<r:layoutResources />
		<g:javascript src="jquery.balloon.js"/>
	</head>
	<body>
		<g:render template="/layouts/header"/>
		<g:layoutBody/>
		<g:render template="/layouts/footer"/>
		<div id="spinner" class="spinner" style=""><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<g:javascript src="application.js"/>
		<r:layoutResources />
	</body>
</html>
