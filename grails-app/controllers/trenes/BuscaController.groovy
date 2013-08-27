package trenes
//import org.compass.core.engine.SearchEngineQueryParseException

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
        //Procesamos la cadena buscada
    	def estaciones = []
        def fechas = []
        def palabras = []
    	palabras = params.q.contains(',')? params.q.tokenize(','): params.q.tokenize()
    	palabras.each {
            println it.trim()
    		if (!it.matches(/(?<=^| )(?=[^ ]*\d)[^ ]+/)) {
		    	//estaciones << searchableService.search("${it} OR ${it}* OR *${it}*".toString(), [max: 6])
                def e = Estacion.findAllByNombreIlike("%${it.trim()}%", params)
                println e
                estaciones << e
		    } else {
                try {
                    fechas << new Date().parse('d/M/y', it).clearTime()
                } catch(e) {
                    flash.message = "$it no parece una fecha válida. Por ejemplo, para introducir como fecha de busqueda el día de hoy, utilice ${new Date().format('d/M/y')}"
                }
                if (flash.message) {
                    println flash.message
                    return [:]
                }
            }
    	}
    	def origenes = estaciones[0]
    	def destinos = estaciones.size() > 1? estaciones[1..-1]: Estacion.findAllByPrincipal(true, params)
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


        return render(view: 'result', model: [searchResult: datos])
    }

    def showTren() {
        [trenes: renfeService.consultarTrenesDisponibles(Trayecto.load(params.trayecto), new Date().parse('dd/MM/yyyy', params.fecha)),
        infoId: params.infoId]
    }

}
