<div class="row">
	<div class="span11">
		<ul class="nav nav-tabs" data-role="listview" data-split-icon="gear" data-filter="true">
		
			<g:each status="i" var="c" in="${grailsApplication.controllerClasses.sort { it.logicalPropertyName } }">
				<li class="controller${params.controller == c.logicalPropertyName ? " active" : ""}">
					<g:link controller="${c.logicalPropertyName}" action="index">
						<g:message code="${c.logicalPropertyName}.label" default="${c.logicalPropertyName.capitalize()}"/>
					</g:link>
				</li>
			</g:each>
			
		</ul>
	</div>
	<div class="span1">
		<div class="">
			<%--Right-side entries--%>
			<%--NOTE: the following menus are in reverse order due to "pull-right" alignment (i.e., right to left)--%>
			<g:render template="/_menu/language"/>														
			<%--<g:render template="/_menu/search"/> --%>
		</div>
	</div>
</div>