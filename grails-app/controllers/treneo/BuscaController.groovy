package treneo
//import org.compass.core.engine.SearchEngineQueryParseException

import grails.util.Environment

/**
 * BuscaController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
class BuscaController {
	def renfeService

    /**
     * Index page with search form and results
     */
    def index() {
        def fonts = ["'font-family', 'Sue Ellen Francisco, cursive'","'font-family', 'Duru Sans, sans-serif'","'font-family', 'Quicksand, sans-serif'","'font-family', 'Oleo Script Swash Caps, cursive'","'font-family', 'Vast Shadow, cursive'","'font-family', 'Smokum, cursive'","'font-family', 'Montserrat Alternates, sans-serif'","'font-family', 'Shojumaru, cursive'","'font-family', 'Peralta, cursive'","'font-family', 'Prosto One, cursive'","'font-family', 'Kavoon, cursive'","'font-family', 'Bubbler One, sans-serif'","'font-family', 'Ceviche One, cursive'","'font-family', 'Ribeye Marrow, cursive'"]

        if (!params.q?.trim()) {
            return [fonts: fonts]
        }

        Environment.executeForCurrentEnvironment {
            production {
                params.q = new String(params.q.getBytes("8859_1"), "UTF8")
            }
        }

        if (Estacion.count() <= 0) {
            renfeService.descargarEstaciones()
        }
        //Procesamos la cadena buscada
        def contenido = interpretar(params.q)
        if (!contenido)
            return [:]

    	def origenes = contenido.estaciones[0]
        def orUrl = []
        if (contenido.estaciones[0] instanceof Collection) {
            origenes.each {
                orUrl << it.toFriendlyUrl()
            } 
        } else {
            orUrl << origenes.toFriendlyUrl()
        }

    	def destinos = contenido.estaciones.size() > 1? contenido.estaciones[1..-1]: Estacion.findAllByPrincipal(true, [max: 3])
        def desUrl = []
        destinos.each {
            it.each { e -> 
                desUrl << e.toFriendlyUrl()
            }
        }

        return render(view: 'result', model: 
            [origenes: orUrl[0], 
            destinos: desUrl, 
            fechas: contenido.fechas.date, 
            dow: contenido.fechas.dow, 
            fonts: fonts,
            nojs: params.nojs])
    }

    def renfe() {
        println params
        if (!params.origen) {
            redirect(action: 'index')
            return
        }
        if (Estacion.count() <= 0) {
            renfeService.descargarEstaciones()
        }
        def origenes = Estacion.findAllByNombreIlike("%${new Estacion(nombre: params.origen).toFriendlySQL()}%") 

        def estaciones = params.destinos? params.destinos.tokenize('/') : []
        def destinos = []
        estaciones.each { 
            destinos << Estacion.findByNombreIlike("%${new Estacion(nombre: it).toFriendlySQL()}%")
        }
        println origenes
        println destinos

        def fechas = params.fechas?.stringToList { new Date().parse('dd/MM/yyyy',it).clearTime() }?:[]

        try {
            def trayectos = renfeService.extraerTrayectos(origenes, destinos)

            if (fechas.size() == 0) {
                def today = new Date().clearTime()
                fechas << today
                fechas << today + 1
                fechas << today + 2
            }
            def datos = []
            trayectos.each { trayecto ->
                fechas.each { fecha ->
                    datos << [trayecto: trayecto, fecha: fecha, url: renfeService.componerURL(trayecto, fecha)]
                }
            }

            return render(template: 'trenes', model: [origenes: origenes, destinos: destinos, searchResult: datos, nojs: params.nojs?:'true'])
        } catch(e) {
            log.error e
            render (status: '503', text: 'Renfe no está online en estos momentos. Pruebe más tarde.')
        }        
    }

    def trenes() {
        if (!params.origenes) {
            redirect(action: 'index')
            return
        }
        def slurper = new groovy.json.JsonSlurper()

        def origenes = params.origenes.stringToList { Estacion.findByNombreLike("${it.trim()}") }
        def destinos = params.destinos.stringToList { Estacion.findByNombreLike("${it.trim()}") }
        def fechas = params.fechas?.stringToList { new Date().parse('dd/MM/yyyy',it).clearTime() }?:[]

        try {
            def trayectos = renfeService.extraerTrayectos(origenes, destinos)

            if (fechas.size() == 0) {
                def today = new Date().clearTime()
                fechas << today
                fechas << today + 1
                fechas << today + 2
            }
            def datos = []
            trayectos.each { trayecto ->
                fechas.each { fecha ->
                    datos << [trayecto: trayecto, fecha: fecha, url: renfeService.componerURL(trayecto, fecha)]
                }
            }

            return render(template: 'trenes', model: [searchResult: datos, nojs: params.nojs?:'false'])
        } catch(e) {
            log.error e
            render (status: '503', text: 'Renfe no está online en estos momentos. Pruebe más tarde.')
        }
    }

    def showTren() {
        if (!params.trayecto?.trim()) {
            redirect(action: 'index')
            return
        }
        try {
            def trenes = renfeService.consultarTrenesDisponibles(params.trayecto, new Date().parse('dd/MM/yyyy', params.fecha))
            render (template: 'showTren', model: [trenes: trenes,
            infoId: params.infoId, nojs: params.nojs?:'false'])
        } catch(e) {
            log.error e
            render (status: '503', text: 'Renfe no está online en estos momentos. Pruebe más tarde.')
        }
    }

    private def interpretar(String frase) {
        def estaciones = []
        def tmpFechas = []
        def palabras = []

        frase = StringDate.convertToDate(frase)
        palabras = frase.tokenize()
        palabras.each {
            if (it.size() < 4)
                return
            if (!it.matches(/(?<=^| )(?=[^ ]*\d)[^ ]+/)) { //palabras
                def e = Estacion.findAllByNombreIlike("%${it.trim()}%", [max: 10])
                if (e) {
                    def generico
                    e.each {
                        if (!generico) {
                            if (it.nombre.contains('(*)'))
                                generico = it
                        }
                    }
                    if (generico) 
                        estaciones << generico
                    else
                        estaciones << e
                }
                else {
                    def min = 100
                    Estacion.list().each { estacion ->
                        estacion.nombre.tokenize().each { nom ->
                            def d = StringMetric.distance(it.trim(), nom)
                            if (d < min) {
                                e = estacion
                                min = d
                            }
                        }
                    }
                    
                    estaciones << e
                }
            } else { //tiene números
                it = it.replace('-','/')
                try {
                    tmpFechas << new Date().parse('d/M/y', it)
                } catch(e) {
                    flash.message = "$it no parece una fecha válida. Por ejemplo, para introducir como fecha de busqueda el día de hoy, utilice ${new Date().format('d/M/y')}"
                }
                if (flash.message) {
                    println flash.message
                    return [:]
                }
            }
        }
        
        def fechas = [date:[], dow:[]]
        tmpFechas.sort().each {
            fechas.date << it.clearTime().format('dd/MM/yyyy')
            fechas.dow << it.getAt(Calendar.DAY_OF_WEEK)
        }

        if (estaciones.size == 0)
            return null
        [estaciones: estaciones, fechas: fechas]
    }
}
