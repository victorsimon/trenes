modules = {
    application {
        resource url:'js/application.js'
    }

	// Utility resources (must be loaded after bootstrap skin resources)
	// Duplication necessary as switching skins causes new skin to be loaded after utilities!
	'bootstrap_utils' {
		dependsOn 'jquery, bootstrap, font-awesome'
		resource url: [dir: 'datepicker/js',			file: 'bootstrap-datepicker.js']
		resource url: [dir: 'datepicker/css',			file: 'datepicker.css']
		resource url: "less/dummy.css" // empty css: see https://github.com/paulfairless/grails-lesscss-resources/issues/25
	}
}

