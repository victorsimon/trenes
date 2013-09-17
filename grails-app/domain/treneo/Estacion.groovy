package treneo

/**
 * Estacion
 * A domain class describes the data object and it's mapping to the database
 */
class Estacion {

	/*static searchable = {
		spellCheck "include"
		only = 'nombre'
	}*/

	String nombre
	String codigoInternacional
	String codigo
	String codigoAlt
	Boolean principal = false
	Boolean buscaprecio = false

	/* Default (injected) attributes of GORM */
//	Long	id
//	Long	version
	
	/* Automatic timestamping of GORM */
//	Date	dateCreated
//	Date	lastUpdated
	
//	static belongsTo	= []	// tells GORM to cascade commands: e.g., delete this object if the "parent" is deleted.
//	static hasOne		= []	// tells GORM to associate another domain object as an owner in a 1-1 mapping
//	static hasMany		= []	// tells GORM to associate other domain objects for a 1-n or n-m mapping
//	static mappedBy		= []	// specifies which property should be used in a mapping 
	
    static mapping = {
    }
    
	static constraints = {
		nombre()
		codigoInternacional()
		codigo()
		codigoAlt()
		principal()
    }

    Estacion(List datos) {
    	nombre = datos[0]
    	def codigos = datos[1].tokenize(',')
    	codigoInternacional = codigos[0]
    	codigo = codigos[1]
    	codigoAlt = codigos[2]
    }
	
	/*
	 * Methods of the Domain Class
	 */

	public String toString() {
		return "${nombre}";
	}

	boolean equals (Object other) {
		if (null == other) return false
		if (! (other instanceof Estacion)) return false
		if (nombre != other.nombre) return false
		if (codigo != other.codigo) return false
		return true
	}

	int hashCode() {
		nombre.hashCode() + codigo.hashCode()
	}
}
