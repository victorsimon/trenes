package treneo

import org.cyberneko.html.parsers.SAXParser
import groovyx.gpars.GParsPool
import static groovyx.gpars.GParsPool.withPool
import org.hibernate.ScrollableResults
import org.hibernate.ScrollMode
import org.hibernate.StatelessSession
import org.hibernate.Transaction
import java.util.concurrent.LinkedBlockingQueue

/**
 * RenfeService
 * A service class encapsulates the core business logic of a Grails application
 */
class RenfeService {

    static transactional = true
    def sessionFactory

    def descargarEstaciones() {
    	new EstadoTarea(tarea: "DescargarEstaciones", info: "Inicio ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
		def source = "http://www.renfe.com/js/estaciones.js".toURL().content.text.replaceAll('var', 'def').tokenize(';')
		def todas = []
		def principales = []
		log.info "Estaciones descargadas. Procesando todas."

		def estaciones = new GroovyShell().evaluate(source[0])
		log.info "Procesadas. Insertando en la base de datos."

		StatelessSession session = sessionFactory.openStatelessSession()
		Transaction tx = session.beginTransaction()
		estaciones.each() { estacion ->
		    def e = new Estacion(estacion)
		    if (!Estacion.findByNombre(e.nombre)) {
			    session.insert(e)
			}
		}
		log.info "Insertadas. Procesando principales."
		tx.commit()
		session.close()

		def estPrincipales = new GroovyShell().evaluate(source[1])
		log.info "Procesadas. Modificando en base de datos."
		estPrincipales.each() { estacion ->
			def e = Estacion.findByNombre(estacion[0])
			if (e) {
				e.principal = true
			    e.save()
			}
		}
		log.info "Modificadas. Hecho."
    	new EstadoTarea(tarea: "DescargarEstaciones", info: "Fin ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
    }

	def extraerTrenesDisponiblesPorDia(Trayecto trayecto, List<Date> salidas) {
    	new EstadoTarea(tarea: "extraerTrenesDisponiblesPorDia", info: "Inicio ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
		def cookieSession = extraerCookieSession()
		salidas.each {salida ->
			def List<ConsultaRenfe> trenesDisponiblesDia = []
			def URLconsulta = componerURL(trayecto, salida)
			def URLConnection conexion = conectarConCookieSession(URLconsulta, cookieSession)
			//try {
				def contenidoLimpio = limpiarContenido(conexion.content.text)
				def Map<String, String> trenesProgramados = extraerTrenes(contenidoLimpio)
				List<ConsultaRenfe> trenes = []

				trenesProgramados.eachWithIndex() { t, i ->
					ConsultaRenfe tmp = convertirLineasEnTrenes(t.value, salida, trayecto.id)
					if (tmp) trenes.add(tmp)
				}
				marcarTrenesObsoletos(salida, trayecto, trenes)
			/*} catch (e) {
		    	new EstadoTarea(tarea: "extraerTrenesDisponiblesPorDia", result: "KO", info: "Exception $e").save(flush: true)
				log.warn "EL SITE DE RENFE ESTA CAIDO $e"
			}*/
		}
    	new EstadoTarea(tarea: "extraerTrenesDisponiblesPorDia", info: "Fin ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
	}

	def consultarTrenesDisponibles(tId, Date salida) {
		def trayecto = Trayecto.read(tId)
		def cookieSession = extraerCookieSession()
		def List<ConsultaRenfe> trenesDisponiblesDia = []
		def URLconsulta = componerURL(trayecto, salida)
		def URLConnection conexion = conectarConCookieSession(URLconsulta, cookieSession)
		def contenidoLimpio = conexion.content.text
		contenidoLimpio = contenidoLimpio.replaceAll(/id\s=\s"longHoy"\s+value="\d+"|"Clase.Ljava.lang.String;@.+">/, '"C">')
		def Map<String, String> trenesProgramados = extraerTrenes(contenidoLimpio)
		List<ConsultaRenfe> trenes = []

		trenesProgramados.eachWithIndex() { t, i ->
			ConsultaRenfe tmp = convertirLineasEnTrenes(t.value, salida, trayecto.id)
			if (tmp) trenes.add(tmp)
		}
		return trenes
	}

	def extraerTrayectos() {
    	new EstadoTarea(tarea: "extraerTrayectos", info: "Inicio ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
		def indices = []
		def es = Estacion.findAllByBuscaprecio(true)
		es.each {
			indices << it.id
		}	
		println indices   	
		extraerTrayectos(indices)
		new EstadoTarea(tarea: "extraerTrayectos", info: "Fin ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
	}

	def extraerTrayectos(List indices) {
    	new EstadoTarea(tarea: "extraerTrayecto $indices", info: "Inicio ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
		def cookie = extraerCookieSession()
		def trayectos = new java.util.concurrent.LinkedBlockingQueue ()

		withPool(8) {

			Closure check = { Long o, Long d ->
					try {
						def estacion = Estacion.read(o)
						def otra = Estacion.read(d)
						if (otra.principal && estacion != otra) {
							if (!Trayecto.findByOrigenAndDestino(estacion, otra)) {
								def trayecto = new Trayecto(origen: estacion, destino: otra)
								if (comprobarTrayecto(trayecto, cookie)) {
									List t = new ArrayList()
									t << o
									t << d
									trayectos << t
								}
							}
						}
					} catch(e) {
						log.info "Creando trayecto:\n ${e.stackTrace()}"							
					}
			}.asyncFun()

			Closure c = { i ->

				ScrollableResults results = Estacion.createCriteria().scroll {
					sqlRestriction "buscaprecio = true"
				}
				while(results.next()) {
					check(i, results.get(0).id)
				}
			}

			indices.each { i ->
		    	new EstadoTarea(tarea: "extraerTrayecto id $i", info: "Inicio ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
				c(i)
		    	new EstadoTarea(tarea: "extraerTrayecto id $i", info: "Fin ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
			}
		}
		trayectos.toArray().each {
			def estacion = Estacion.read(it[0])
			def otra = Estacion.read(it[1])
			new Trayecto(origen: estacion, destino: otra).save(flush: true)
		}
    	new EstadoTarea(tarea: "extraerTrayecto $indices", info: "Fin ${new Date().format('dd/MM/yyyy HH:mm.s')}").save(flush: true)
	}

	def extraerTrayectos(List origenes, List destinos) {
		def cookie = extraerCookieSession()
		def tmp = []
		def nuevos = new LinkedBlockingQueue()
		def trayectos = []
		def tmpTrayectos = new LinkedBlockingQueue()

		origenes.each { origen ->
			destinos.each { destino ->
				destino.each { otra ->
					if (origen != otra) {
						def o = Estacion.get(origen.id)
						def d = Estacion.get(otra.id)
						def trayecto = new Trayecto(origen: o, destino: d)
						def existe = false
						if (Trayecto.findByOrigenAndDestino(o, d))
							existe = true
						tmp << [o: o.id, d: d.id, existe: existe]
					}
				}
			}
		}

		withPool {
			tmp.findAllParallel { 
				if (!it.existe) {
					def o = Estacion.read(it.o)
					def d = Estacion.read(it.d)
					def trayecto = new Trayecto(origen: o, destino: d)
					if (comprobarTrayecto(trayecto, cookie)) {
						nuevos << trayecto
						return true
					} else {
						return false
					}
				} else {
					return true
				}
			}.collectParallel {
				tmpTrayectos << it
			}
		}

		nuevos.each {
			trayectos << it.save()
		}

		tmpTrayectos.each {
			if (it.existe) {
				def o = Estacion.get(it.o)
				def d = Estacion.get(it.d)
				trayectos << Trayecto.findByOrigenAndDestino(o, d)
			}

		}		
    	return trayectos
	}

	def comprobarTrayecto(Trayecto trayecto, cookie) {
		def fecha = new Date() + 3
		def URL = componerURL(trayecto, fecha)
		def conexion = conectarConCookieSession(URL, cookie)
		def html 
		for(int x = 0; x < 3; x++) {
			try {
				html = conexion.content.text
				break
			} catch(e) {
				log.error "comprobarTrayecto $trayecto [$e]"
			}
		}
		if (!html)
			return false
		//def contenido = limpiarContenido(html)
		def directo = comprobarConexionDirecto(html)
		return directo
	}
	
	/**
	* Metodos privados
	*/

	public ConsultaRenfe convertirLineasEnTrenes(String source, Date fecha, tId) {
		def trenProgramado = source.split ("\\|")
		def horaSalida = setHora(fecha, trenProgramado[7].split("\\.")[0],
				trenProgramado[7].split("\\.")[1])
		def horaLlegada = setHora(fecha, trenProgramado[8].split("\\.")[0],
				trenProgramado[8].split("\\.")[1])
		if (horaLlegada < horaSalida) //Ajustamos el dia si llega al d�a siguiente (la programaci�n no da la info necesaria)
			horaLlegada = horaLlegada + 1

		//log.info "source $source"
		def trayecto = Trayecto.get(tId)
		def clase = Clase.findByCodigo(trenProgramado[0].trim())?: new Clase(nombre: trenProgramado[11].trim(), codigo: trenProgramado[0].trim()).save(flush: true)
		def tren = Tren.findByTipoAndNumero(trenProgramado[4].trim(), trenProgramado[1].trim())?: new Tren(tipo: trenProgramado[4].trim(), numero: trenProgramado[1].trim()).save(flush: true)
		def tarifa = Tarifa.findByCodigo(trenProgramado[9].trim())?: new Tarifa(nombre: trenProgramado[9].trim(), codigo: trenProgramado[9].trim()).save(flush: true)
		//def consultaRenfe = ConsultaRenfe.findByRawData(source) 
		//log.info consultaRenfe
		//if (!consultaRenfe) {
		def consultaRenfe
			try {
				consultaRenfe = new ConsultaRenfe(
					clase: clase,
					tren: tren,
					trayecto: trayecto,
					fecha: fecha,
					salida: horaSalida,
					llegada: horaLlegada,
					precio: trenProgramado[12],
					tarifa: tarifa,
					noValido: false,
					rawData: source
					)
				/*if (!consultaRenfe.save(flush: true)) {
					consultaRenfe.errors.each {
						log.error it
					}
				}*/
			} catch(e) {
				log.error "$source produjo un error"
				log.error "$e"
				log.error "${e.getStackTrace()}"
			}
		/*} else {
			consultaRenfe.noValido = false
			consultaRenfe.save(flush: true)
		}*/
		return consultaRenfe
	}
	
	private String limpiarContenido(String content) {
		//content = content.replaceAll(/<!DOCTYPE.+>/, "<!DOCTYPE html>")
		content = content.replaceAll(/id\s=\s"longHoy"\s+value="\d+"/, "C")
		content = content.replaceAll(/"Clase.Ljava.lang.String;@.+">/, '"C">')
		return content
	}
	
	private marcarTrenesObsoletos(Date salida, Trayecto trayecto, List<ConsultaRenfe> trenesAMantener) {
		def trenesBorrar = ConsultaRenfe.findByFechaAndTrayecto(salida, trayecto)
		trenesBorrar.each { ConsultaRenfe tren ->
			if (!trenesAMantener.contains(tren)) {
				tren.noValido = true
			}
			tren.save(flush: true)
		}
	}
	
	private setHora(Date fechaOriginal, String hora, String minuto) {
		def _hora = "${hora.padLeft(2, '0')}:${minuto.padLeft(2, '0')}"
		def fechaYHora = new Date().parse("dd/MM/yyyy HH:mm", "${fechaOriginal.format('dd/MM/yyyy')} $_hora")
		return fechaYHora
	}

	private Map<String, String> extraerTrenes(String busqueda) {
		def parser = new SAXParser()
		parser.setFeature("http://xml.org/sax/features/namespaces", false);
		def slurper = new XmlSlurper(parser)
		def htmlParser = slurper.parseText(busqueda)

		def Map<String, String> trenes = [:]
		htmlParser.'**'.findAll { it.@id.toString() ==~ /trenClaseOcupacion[0-9]+/ }.each {
			def precio = "0${it.parent().text().trim().replaceAll(",", ".")}".toBigDecimal()
			def data = it.@value.toString() + '|' + precio
			//log.info "${it.@id.toString()} ${data}"
			def tok = data.tokenize('|')
			trenes.put( "${tok[0]}|${tok[1]}|${tok[9]}|${tok[10]}|${tok[12]}", data)
			//println "${tok[0]}|${tok[1]}|${tok[9]}|${tok[10]}|${tok[12]}" + " <=> $data"
		}
		return trenes
	}

	private Boolean comprobarConexionDirecto(String busqueda) {
		def error = busqueda.contains(/NOtitulo_ida_full1/)
		/*def parser = new SAXParser()
		parser.setFeature("http://xml.org/sax/features/namespaces", false);
		def slurper = new XmlSlurper(parser)
		def htmlParser = slurper.parseText(busqueda)

		def error = htmlParser.'**'.find { it.@class.toString() ==~ /NOtitulo_ida_full1/ }
		//log.debug "comprobarConexionDirecto -> $error"*/
		return error? false: true
	}

	private synchronized conectarConCookieSession(String URL, List cookie) {
		def busqueda = URL.toURL().openConnection()
		if (cookie)
			busqueda.setRequestProperty('Cookie', cookie.toString())
		return busqueda
	}

	public List extraerCookieSession() {
		def inicio = "https://venta.renfe.com/vol/index.do".toURL().openConnection()
		def cookie
		inicio.getHeaderFields().each {
			if (it.getKey() == 'Set-Cookie')
				cookie = it.getValue()
		}
		return cookie
	}

	public String componerURL(Trayecto trayecto, Date fecha) {
        def nombreOrigen = URLEncoder.encode(trayecto.origen.nombre)
        def nombreDestino = URLEncoder.encode(trayecto.destino.nombre)
        def codOrigen = URLEncoder.encode(trayecto.origen.codigo)
        def codDestino = URLEncoder.encode(trayecto.destino.codigo)
        def salida = URLEncoder.encode(fecha.format("dd/MM/yyyy"))
        def URL = "https://venta.renfe.com/vol/buscarTren.do?" +
                "url_logout=&tipoUsuario=N&targetUsuario=&idioma=&pais=&" +
                "MODULO=&desOrigen=${nombreOrigen}&desDestino=${nombreDestino}&ninos=0&" +
                "currenLocation=menuBusqueda&operation=&grupos=false&" +
                "tipoOperacion=IND&empresas=false&iv=i&" +
                "IdOrigen=${codOrigen}&FechaIdaSel=${salida}&HoraIdaSel=00%3A00&" +
                "IdDestino=${codDestino}&adultos=1&desOrigen=&desDestino=&ninos=0&txtoUsuario=&" +
                "txtoPass=&pagina%2F=&msgRedirigirALogin=Se+ha+producido+un+error+al+cargar+el+Journal"
        return URL
	}

}
