package trenes

class StringDate {

	def static String convertToDate(String txt) {
		txt = " " + txt.toLowerCase()
		txt = txt.replace(' la ', ' ')
		txt = txt.replace(' el ', ' ')
		txt = txt.replace(' que ', ' ')
		txt = txt.replace(' y ', ' ')
		txt = txt.replace(' de ', ' ')
		txt = txt.replace(' a ', ' ')
		txt = txt.replace(' desde ', ' ')
		txt = txt.replace(' hasta ', ' ')

		if (txt.contains('pasado mañana')){
			def nueva = (new Date() + 2).format('dd/MM/yyyy')
			return txt.replace('pasado mañana', nueva)
		} else if (txt.contains('mañana')) {
			def nueva = (new Date() + 1).format('dd/MM/yyyy')
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
				nueva += current.format('dd/MM/yyyy') + ' '
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
			def lunes
			for(int i = 1; i <= 7; i++) {
				def current = new Date() + i
				if (current[Calendar.DAY_OF_WEEK] == Calendar.MONDAY) {
					lunes = current 
					break
				}
			}
			def nueva = ""
			(0..6).each {
				nueva += (lunes + it).format('dd/MM/yyyy') + ' '
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
				nueva += dia.format('dd/MM/yyyy') + ' '
				dia++		
				if (actual != dia.month)
					break
			}
			return txt.replace(exp, nueva)
		}
		return txt
	}
}