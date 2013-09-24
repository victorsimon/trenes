<!DOCTYPE HTML>
<html lang="es" class="no-js">
    <head>
        <title><g:layoutTitle default="Treneo" /></title>
      <meta http-equiv="content-type" content="text/html;charset=UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Treneo</title>
      <g:set var="colors" value="['#34a5aa', '#aaaaaa', '#4789aa', '#d3e310']"/>
      <script type="text/javascript" src="http://www.renfe.com/js/estaciones.js" ></script>
      <r:require modules="jquery"/>
      <r:require modules="bootstrap"/>
      <script src="path/to/jquery.cookie.js"></script>
      <g:layoutHead />
      <r:layoutResources />
      <script type="text/javascript" src="../js/jquery.suggest.js" ></script>
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>    
        <div class="logo"><img src="${createLinkTo(dir:'images',file:'mylogo.jpg')}" alt="Sales Demo" /></div>        <g:layoutBody />
    </body>
</html>