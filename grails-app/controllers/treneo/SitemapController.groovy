package treneo

import org.springframework.transaction.annotation.Transactional

/**
 * SitemapController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
class SitemapController {

	def renfeService

	@Transactional(readOnly = true)
    def index() {
        if (Estacion.count() <= 0) {
            renfeService.descargarEstaciones()
        }

    	render(contentType: 'text/xml', encoding: 'UTF-8') {
            mkp.yieldUnescaped '<?xml version="1.0" encoding="UTF-8"?>'
            urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9",
                    'xmlns:xsi': "http://www.w3.org/2001/XMLSchema-instance",
                    'xsi:schemaLocation': "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd") {
	            url {
	                loc(g.createLink(absolute: true, uri: "/"))
	                changefreq('daily')
	                priority(0.8)
	            }

	            def e1 = Estacion.findAllPrincipal(true)
	            def e2 = Estacion.findAllPrincipal(true)
	            println e1.size()
	            println e2.size()
	            e1.each { eo ->
	            	e2.each { ed ->
	            		if (eo != ed) {
			                url {
			                    loc(g.createLink(absolute: true, uri: "/renfe/${eo.toFriendlyUrl()}/${ed.toFriendlyUrl()}"))
			                    changefreq('daily')
			                    priority(0.8)
			                }		                	
			            }
	            	}
	            }
	        }
        }
    }
}
