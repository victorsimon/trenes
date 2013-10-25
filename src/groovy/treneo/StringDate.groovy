package treneo

class StringDate {

	def static char delimiter = 127 as char

	def static String convertToDate(String txt) {
		txt = " " + txt.toLowerCase() + " "
		txt = txt.replace(' la ', ' ')
		txt = txt.replace(' el ', ' ')
		txt = txt.replace(' que ', ' ')
		txt = txt.replace(' y ', ' ')
		txt = txt.replace(' de ', ' ')
		txt = txt.replace(' a ', ' ')
		txt = txt.replace(' desde ', ' ')
		txt = txt.replace(' hasta ', ' ')

		if (txt.contains(' hoy ')){
			def nueva = ' ' + new Date().format('dd/MM/yyyy') + delimiter + ' '
			return txt.replace(' hoy ', nueva)
		}
		if (txt.contains('pasado mañana')){
			def nueva = (new Date() + 2).format('dd/MM/yyyy') + delimiter + ' '
			return txt.replace('pasado mañana', nueva)
		} else if (txt.contains('mañana')) {
			def nueva = (new Date() + 1).format('dd/MM/yyyy') + delimiter + ' '
			return txt.replace('mañana', nueva)
		}
		txt = estaSemana('esta semana', txt)
		[
		'semana viene', 'proxima semana', 'próxima semana', 
		'semana siguiente', 'semana proxima', 'semana próxima', 
		].each {
			txt = semana(it, txt)
		}
		def i = 0
		[
		'próximo lunes', 'próximo martes', 'próximo miercoles', 'próximo jueves', 'próximo vierne', 'próximo sabado', 'próximo sábado', 'domingo próximo ', 
		'proximo lunes', 'proximo martes', 'proximo miercoles', 'proximo jueves', 'proximo vierne', 'proximo sabado', 'proximo sábado', 'domingo proximo ', 
		'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sábado', 'domingo' 
		].each { it ->
			txt = diaSemana(it, txt)
		}

		[
		'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 
		'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
		].each { it ->
			txt = mes(it, i++, txt)
		}

		[
		'proximo mes', 'próximo mes',
		'mes proximo', 'mes próximo',
		'mes viene', 'mes siguiente', 'siguiente mes'
		].each { it ->
			txt = mes(it, new Date().month + 1, txt)
		}

		txt
	}

	private static String estaSemana(String exp, String txt) {
		if (txt.contains(exp)) {
			def nueva = ""
			for(int i = 0; i <= 7; i++) {
				def current = new Date() + i
				nueva += current.format('dd/MM/yyyy') + delimiter + ' '
				if (current[Calendar.DAY_OF_WEEK] == Calendar.SUNDAY) {
					break
				}
			}
			return txt.replace(exp, nueva)
		}
		return txt
	}

	private static String semana(String exp, String txt) {
		if (txt.contains(exp)) {
			def lunes = getNextDayOfWeek(Calendar.MONDAY)
			def nueva = ""
			(0..6).each {
				nueva += (lunes + it).format('dd/MM/yyyy') + delimiter + ' '
			}
			return txt.replace(exp, nueva)
		}
		return txt
	}

	private static Date getNextDayOfWeek(def dow) {
		for(int i = 1; i <= 7; i++) {
			def current = new Date() + i
			if (current[Calendar.DAY_OF_WEEK] == dow) {
				return current
			}
		}
	}

	private static String diaSemana(String exp, String txt) {
		if (txt.contains(exp)) {
			def nueva = " "
			switch(exp.replace("proximo", "").replace("próximo", "").trim()) {
				case "lunes":
					nueva = getNextDayOfWeek(Calendar.MONDAY).format("dd/MM/yyyy")
					println ">>>>>" + nueva
				break
				case "martes":
					nueva = getNextDayOfWeek(Calendar.TUESDAY).format("dd/MM/yyyy")
				break
				case "miercoles":
					nueva = getNextDayOfWeek(Calendar.WEDNESDAY).format("dd/MM/yyyy")
				break
				case "jueves":
					nueva = getNextDayOfWeek(Calendar.THURSDAY).format("dd/MM/yyyy")
				break
				case "viernes":
					nueva = getNextDayOfWeek(Calendar.FRIDAY).format("dd/MM/yyyy")
				break
				case "sabado":
				case "sábado":
					nueva = getNextDayOfWeek(Calendar.SATURDAY).format("dd/MM/yyyy")
				break
				case "domingo":
					nueva = getNextDayOfWeek(Calendar.SUNDAY).format("dd/MM/yyyy")
				break
			}
			return txt.replace(exp, nueva)
		}
		return txt
	}

	private static String mes(String exp, Integer i, String txt) {
		if (txt.contains(exp)) {
			def nueva = " "
			def dia = new Date()
			def actual = dia.month
			if (i != actual) {
				dia.set(month: i)
				dia = dia.parse('dd/MM/yyyy', '01' + dia.format('/MM/yyyy'))
				println dia.format('dd/MM/yyyy')
			}
			while(true) {
				actual = dia.month
				nueva += dia.format('dd/MM/yyyy') + delimiter + ' '
				dia++		
				if (actual != dia.month)
					break
			}
			return txt.replace(exp, nueva)
		}
		return txt
	}
}