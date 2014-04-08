package treneo
//import org.compass.core.engine.SearchEngineQueryParseException

import grails.util.Environment
import grails.converters.JSON

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
        if (!params.q?.trim()) {
            return []
        }
    }

    def result() {
        if (!params.q?.trim()) {
            return redirect(view: "index")
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
            nojs: params.nojs])
    }

    def renfe() {        
        if (!params.origen) {
            redirect(action: 'index')
            return
        }
        if (Estacion.count() <= 0) {
            renfeService.descargarEstaciones()
        }
        def origenes = []
        /*
        def exacto = Estacion.findByNombreIlike("${new Estacion(nombre: params.origen).toFriendlySQL()}")
        if (exacto)
            origenes << exacto
        else
            origenes.addAll(Estacion.findAllByNombreIlike("%${new Estacion(nombre: params.origen).toFriendlySQL()}%"))
        */
        origenes = buscaEstacion("${new Estacion(nombre: params.origen).toFriendlySQL()}")
        def estaciones = params.destinos? params.destinos.tokenize('/') : []
        def destinos = []
        estaciones.each { 
            destinos << Estacion.findByNombreIlike("%${new Estacion(nombre: it).toFriendlySQL()}%")
        }                

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

    def query() {
        if (!params.query) {
            render [] as JSON
            return
        }
        def result = params.query.find(/([^ ]+)$/)

        def source = []
        def ws = params.query.tokenize()
        for (int i = 0; i < ws.size(); i++) {
            println "%${ws[i..-1].join(' ')}%"
            def e = Fecha.createCriteria().list { 
                ilike ("nombre", "%${ws[i..-1].join(' ')}%")
                projections { property('nombre') } }
            if (e) {
                source.addAll(e)
                i = ws.size()
            }
        }

		100.times {
			source << (new Date() + it).format("dd/MM/yyyy")	
		}
		
        source.addAll(Estacion.createCriteria().list { 
            ilike ("nombre", "%${result}%")
            projections { property('nombre') } })

        def sentence = []
        source.each {
            sentence << params.query - ~/([^ ]+)$/ + it
        }
        render sentence as JSON
    }

    private def interpretar(String frase) {
        def estaciones = []
        def tmpFechas = []
        def palabras = []

        frase = StringDate.convertToDate(frase.trim())
        palabras = frase.tokenize()
        for(int i = 0; i < palabras.size; i++) {
            def fraseTmp = palabras[i..-1]
            def n = fraseTmp.size - 1
            while (n >= 0) {                                
                if (interpretaPalabras(fraseTmp[0..n].join(' ').trim(), estaciones, tmpFechas)) {
                    for(int c = i; c <= i+n; c++) {                        
                        palabras[c] = ""
                    }
                    n = -1
                }
                n--
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

    private Boolean interpretaPalabras(String word, estaciones, fechas){
        word = word.trim()
        if (word.size() < 4) {
            return false
        } 
        if (!word.matches(/(?<=^| )(?=[^ ]*\d)[^ ]+/)) { //palabras
            def tmp = buscaEstacion(word)
            if (tmp) {
                estaciones.addAll(tmp)                 
                return true
            }
        } else { //tiene números
            word = word.replace('-','/')
            try {
                fechas << new Date().parse('d/M/y', word)                
            } catch(e) {
                flash.message = "$word no parece una fecha válida. Por ejemplo, para introducir como fecha de busqueda el día de hoy, utilice ${new Date().format('d/M/y')}"
            }
            if (flash.message) {                
                return false
            } else {
                return true
            }
        }
        return false
    }

    private def buscaEstacion(String word){        
        def estaciones = []
        if (!word.trim())
            return []
        def exact = Estacion.findByNombreIlike("${word.trim()}")
        if (exact) {
            estaciones << exact
            return estaciones
        }    
        def e = Estacion.findAllByNombreIlike("%${word.replaceAll(' ','%').trim()}%", [max: 7])
        if (e) {
            def generico
            e.each {
                if (!generico) {
                    if (it.nombre.contains('(*)'))
                        generico = it
                }
            }
            if (generico) 
                estaciones.addAll(generico)
            else
                estaciones.addAll(e)
        }
        else {
            def min = 100
            def l = 0
            Estacion.list().each { estacion ->
                if (estacion.nombre.size() >= word.size()){
                    estacion.nombre.tokenize('/').each { nom ->
                        def d = StringMetric.distance(word, nom)
                        if (d < min) {
                            e = estacion
                            min = d
                            l = nom.size()
                        }
                    }
                }
            }
            if (min < 5) {                
                estaciones.addAll(e)
            }
        }
        
        return estaciones
    }
}
