package treneo

/**
 * ControlController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
class ControlController {

	def renfeService

	//static scaffold = true
	def index() { 
		['trayectos': Trayecto.list()]
	}

	def descargarEstaciones() {
		renfeService.descargarEstaciones()
		flash.message = "control.estacionesdescargadas"
		flash.args = ["${Estacion.count()}"]
		flash.default ="Estaciones descargadas {0}"
        redirect(action: 'index')
	}

	def extraerTrayectos() {
		def nombre = params.estacionInput
		println "$nombre"
		def estacion = Estacion.findByNombre(nombre)
		if (!estacion) {
			flash.message = "control.extraertrayectos.error"
			flash.default ="La estacion seleccionada no existe"
		} else {
			renfeService.extraerTrayectos([estacion.id])
		}
        redirect(action: 'index')			
	}

	def extraerTodosTrayectos() {
		renfeService.extraerTrayectos()
        redirect(action: 'index')			
	}

	def extraerTrenesDisponiblesPorDia() {
		def trayecto = Trayecto.get(params.trayecto)
		def salida = new Date().parse('yyyy-MM-dd', params.fecha)
		def salidas = []
		Integer dias = new Integer(params.dias)
		if (dias < 0) {
			flash.message = "control.dias.menorquecero.error"
			flash.default ="Los dias seleccionados deben ser superiores a 0"
		} else {
			dias.times {
				salidas << salida++
			}
			renfeService.extraerTrenesDisponiblesPorDia(trayecto, salidas)
		}
        redirect(action: 'index')			
	}

	def estraerTodosTrenesPorDia() {
		def trayectos = Trayecto.list()
		def salida = new Date().parse('yyyy-MM-dd', params.fecha)
		def salidas = []
		Integer dias = new Integer(params.dias)
		if (dias < 0) {
			flash.message = "control.dias.menorquecero.error"
			flash.default ="Los dias seleccionados deben ser superiores a 0"
		} else {
			dias.times {
				salidas << salida++
			}
			trayectos.each { trayecto -> 
				renfeService.extraerTrenesDisponiblesPorDia(trayecto, salidas)
			}
		}
        redirect(action: 'index')					
	}
}
