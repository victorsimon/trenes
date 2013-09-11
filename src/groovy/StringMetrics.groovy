package trenes

class StringMetric {

	enum Metric {
		LEVENSHTEIN(Levenshtein)
		Metric(def alg) { this.alg = alg}
		private def alg
		public alg() {return alg}
	}

	def static int distance(String str1, String str2) {	
		Metric.LEVENSHTEIN.alg().distance(str1, str2)
	}

}

