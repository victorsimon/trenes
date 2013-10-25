modules = {
    application {
        resource url:'js/application.js'
    }

	if ( (grails.resources?.processing?.enabled != [:] && grails.resources.processing.enabled.booleanValue() == false) ) {
		/* Bootstrap definitions without less (if resource processing is switched off) */
		'bootstrap' {
			dependsOn 'jquery'
			resource url: [dir: 'bootstrap/js',			file: 'bootstrap.min.js']
			resource url: [dir: 'bootstrap/css',		file: 'bootstrap.css']
			resource url: [dir: 'bootstrap/css',		file: 'bootstrap-responsive.css']
		}
		println "| Using CSS files instead of generating from LESS files! (resource processing was switched off)"
	} else {
		/* Bootstrap definitions with less */
		'bootstrap' {
			dependsOn   'jquery'
			resource url: [dir: 'bootstrap/js',			file: 'bootstrap.min.js']
			resource url: [dir: 'less/bootstrap',		file: 'bootstrap.less']
			resource url: [dir: 'less/bootstrap',		file: 'responsive.less']
	  		resource url: "less/dummy.css" // empty css: see https://github.com/paulfairless/grails-lesscss-resources/issues/25
		}
		println "| Using LESS files to generating CSS files!"
	}

	// Utility resources (must be loaded after bootstrap skin resources)
	// Duplication necessary as switching skins causes new skin to be loaded after utilities!
	'bootstrap_utils' {
		dependsOn 'jquery, bootstrap, font-awesome'
		resource url: [dir: 'datepicker/js',			file: 'bootstrap-datepicker.js']
		resource url: [dir: 'datepicker/css',			file: 'datepicker.css']
		resource url: "less/dummy.css" // empty css: see https://github.com/paulfairless/grails-lesscss-resources/issues/25
	}

	'jquery-extra' {
		resource url: [dir: 'js',			file: 'jquery.cookie.js']
		resource url: [dir: 'js',			file: 'jquery.suggest.js']
	}

	'index' {
		dependsOn	'application'
		resource url: "css/index.css"	
	}

	'result' {
		dependsOn	'application'
		resource url: "css/result.css"	
	}
}

