package treneo

/**
 * Term
 * A domain class describes the data object and it's mapping to the database
 */
class Term {

	String text
	String normalized
	Integer words 
    
	static constraints = {
		text(blank: false)
		normalized(nullable: true)
    }

    String getNormalized() {
    	if (!normalized && text)
    		normalized = normalize(text)
    	return normalized
    }
	
	Integer getWords() {
		if (!words && text)
			words = getNormalized().tokenize().size()
		return words
	}
	/*
	 * Methods of the Domain Class
	 */
	@Override	// Override toString for a nicer / more descriptive UI 
	public String toString() {
		return "${text}"
	}

	public Boolean match(String text) {
		normalized == normalize(text)
	}

	public Boolean match(Term other) {
		normalized == other.normalized
	}

	public Boolean inside(String text) {
		normalize(text).contains(this.normalized)
	}

	public Boolean inside(Term other) {
		other.words >= this.words && other.normalized.contains(this.normalized)
	}

	public static String normalize(String raw) {
		return raw.replaceAll(/(\s)+/, " ").trim().toLowerCase()
	}

}
