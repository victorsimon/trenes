package trenes

/**
 * ConsultaRenfe
 * A domain class describes the data object and it's mapping to the database
 */
class ConsultaRenfe {

	Clase clase
	Tren tren 
	Trayecto trayecto
	Date fecha
	Date salida
	Date llegada
	String precio
	Tarifa tarifa
	Boolean noValido

	String rawData

    public setSalida(Date salida) {
    	this.salida = salida
    	this.salida.putAt(Calendar.SECOND, 0) // Despreciamos los segundo
		this.salida.putAt(Calendar.MILLISECOND, 0) // Despreciamos los segundo
    }
	
    public setLlegada(Date llegada) {
    	this.llegada = llegada
    	this.llegada.putAt(Calendar.SECOND, 0) // Despreciamos los segundo
		this.llegada.putAt(Calendar.MILLISECOND, 0) // Despreciamos los segundo
    }

}
