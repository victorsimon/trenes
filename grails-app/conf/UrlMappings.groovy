class UrlMappings {

	static mappings = {
		
		/* 
		 * Pages without controller 
		 */
//		"/"				(view:"/index")
/*		"/about"		(view:"/siteinfo/about")
		"/blog"			(view:"/siteinfo/blog")
		"/systeminfo"	(view:"/siteinfo/systeminfo")
		"/contact"		(view:"/siteinfo/contact")
		"/terms"		(view:"/siteinfo/terms")
		"/imprint"		(view:"/siteinfo/imprint")
		"/nextSteps"	(view:"/home/nextSteps")
*/		
		/* 
		 * Pages with controller
		 * WARN: No domain/controller should be named "api" or "mobile" or "web"!
        "/$action?/?"	{
			controller	= 'busca'
        }
		 */
        "/"	{
			controller	= 'busca'
			action = 'index'
        }
        "/result" 
        {
        	controller = "busca"
        	action = "result"
        }
        "/query"	{
			controller	= 'busca'
			action = 'query'
        }
        "/tren"	{
			controller	= 'busca'
			action = 'showTren'
        }
        "/renfe/$origen/$destinos**?" {
			controller	= 'busca'
			action = 'renfe'
        }

        "/sitemap" {
        	controller = "sitemap"
        }
/*		"/$controller/$action?/$id?"{
			constraints {
				controller(matches:/^((?!(api|mobile|web)).*)$/)
		  	}
		}
*/		
		/* 
		 * System Pages without controller 
		 */
		"403"	(view:'/_errors/403')
		"404"	(view:'/_errors/404')
		"500"	(view:'/_errors/error')
		"503"	(view:'/_errors/503')

	}
}
