package treneo

/**
 * DateTerm
 * A domain class describes the data object and it's mapping to the database
 */
class DateTerm extends Term {

	List<Date> period
    
	static constraints = {
		period()
    }
	
	public Boolean match(Collection otherPeriod) {
		period == otherPeriod
	}

	public Boolean inside(List<Date> otherPeriod) {
		otherPeriod.contains(period)
	}

}
