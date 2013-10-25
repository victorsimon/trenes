import treneo.Fecha

class BootStrap {

    def init = { servletContext ->
	    String.metaClass.stringToList = { Closure closure ->
	        def l = []
	        delegate.replace('[', ' ').replace(']', ' ').tokenize(',').each {
	            if (it.trim())
	                l << closure("${it.trim()}")
	        }
	        return l
	    }

	    new Fecha(nombre: "hoy").save();
	    new Fecha(nombre: "mañana").save();
	    new Fecha(nombre: "pasado mañana").save();

		new Fecha(nombre: "esta semana").save();
		new Fecha(nombre: "la próxima semana").save();
		new Fecha(nombre: "la semana próxima").save();
		new Fecha(nombre: "la semana que viene").save();
		new Fecha(nombre: "la semana siguiente").save();
		new Fecha(nombre: "la semana que viene").save();

		new Fecha(nombre: "el lunes").save();
		new Fecha(nombre: "el martes").save();
		new Fecha(nombre: "el miercoles").save();
		new Fecha(nombre: "el jueves").save();
		new Fecha(nombre: "el viernes").save();
		new Fecha(nombre: "el sabado").save();
		new Fecha(nombre: "el domingo").save();
		new Fecha(nombre: "el próximo lunes").save();
		new Fecha(nombre: "el próximo martes").save();
		new Fecha(nombre: "el próximo miercoles").save();
		new Fecha(nombre: "el próximo jueves").save();
		new Fecha(nombre: "el próximo viernes").save();
		new Fecha(nombre: "el próximo sabado").save();
		new Fecha(nombre: "el próximo domingo").save();

		new Fecha(nombre: "en enero").save();		
		new Fecha(nombre: "en febrero").save();		
		new Fecha(nombre: "en marzo").save();		
		new Fecha(nombre: "en abril").save();		
		new Fecha(nombre: "en mayo").save();		
		new Fecha(nombre: "en junio").save();		
		new Fecha(nombre: "en julio").save();		
		new Fecha(nombre: "en agosto").save();		
		new Fecha(nombre: "en septiembre").save();		
		new Fecha(nombre: "en octubre").save();		
		new Fecha(nombre: "en noviembre").save();		
		new Fecha(nombre: "en diciembre").save();		

		new Fecha(nombre: "el mes que viene").save();		
		new Fecha(nombre: "el próximo mes").save();		
    }
    def destroy = {
    }
}
