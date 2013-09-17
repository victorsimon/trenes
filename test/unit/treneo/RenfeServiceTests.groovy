package treneo



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(RenfeService)
@Mock([Estacion, ConsultaRenfe, Clase, Tren, Tarifa, Trayecto])
class RenfeServiceTests {

    void testDescargarEstaciones() {
		service.descargarEstaciones()

		assert Estacion.count() > 0

		def madrid = Estacion.findByNombre("Madrid (*)")
		assert madrid.codigo == "MADRI"

		def pamplona = Estacion.findByNombre("Pamplona")
		assert pamplona.codigo == "80100"

		def madridCod = Estacion.findByCodigo("MADRI")
		assert madridCod
		assert madrid == madridCod
    }

    void testTrenesDisponiblesPorDia() {
    	def madrid = new Estacion(nombre: "Madrid", codigo: "MADRI")
    	def pamplona = new Estacion(nombre: "Pamplona", codigo: "80100")
    	def trayecto = new Trayecto(origen: madrid, destino: pamplona)
    	def fecha = new Date() + 1
    	def fechas = []
    	10.times {
    		fechas << fecha + it
    	}

    	service.extraerTrenesDisponiblesPorDia(trayecto, fechas)

    }

    void testExtraerTrayectos() {
        descargarEstaciones()

        service.extraerTrayectos([1])

    }
}
