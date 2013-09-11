package trenes
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
        if (!params.q?.trim()) {
            return [:]
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

    	def origenes = contenido.estaciones[0]
    	def destinos = contenido.estaciones.size() > 1? contenido.estaciones[1..-1]: Estacion.findAllByPrincipal(true, params)

        return render(view: 'result', model: [origenes: origenes, destinos: destinos, fechas: contenido.fechas])
    }

    def trenes() {
        if (!params.origenes?.trim()) {
            return [:]
        }
        def origenes = params.origenes.stringToList { Estacion.findByNombreLike("${it.trim()}") }
        def destinos = params.destinos.stringToList { Estacion.findByNombreLike("${it.trim()}") }
        def fechas = params.fechas.stringToList {new Date().parse('dd/MM/yyyy', it)}

        def trayectos = renfeService.extraerTrayectos(origenes, destinos)

        if (fechas.size() == 0) {
            fechas << new Date().clearTime()
            fechas << new Date().clearTime() + 1
            fechas << new Date().clearTime() + 2
        }
        def datos = []
        trayectos.each { trayecto ->
            fechas.each { fecha ->
                datos << [trayecto: trayecto, fecha: fecha, url: renfeService.componerURL(trayecto, fecha)]
            }
        }

        return render(template: 'trenes', model: [searchResult: datos])
    }

    def showTren() {
        if (!params.trayecto?.trim()) {
            return [:]
        }
        render (template: 'showTren', model: [trenes: renfeService.consultarTrenesDisponibles(params.trayecto, new Date().parse('dd/MM/yyyy', params.fecha)),
        infoId: params.infoId])
    }

    private def interpretar(String frase) {
        def estaciones = []
        def fechas = []
        def palabras = []

        frase = StringDate.convertToDate(frase)
        palabras = frase.tokenize()
        palabras.each {
            if (!it.matches(/(?<=^| )(?=[^ ]*\d)[^ ]+/)) { //palabras
                def e = Estacion.findAllByNombreIlike("%${it.trim()}%", [max: 10])
                if (e)
                    estaciones << e
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
                    fechas << new Date().parse('d/M/y', it).clearTime().format('dd/MM/yyyy')
                } catch(e) {
                    flash.message = "$it no parece una fecha válida. Por ejemplo, para introducir como fecha de busqueda el día de hoy, utilice ${new Date().format('d/M/y')}"
                }
                if (flash.message) {
                    println flash.message
                    return [:]
                }
            }
        }
        [estaciones: estaciones, fechas: fechas]
    }
}
