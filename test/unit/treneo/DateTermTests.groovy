package treneo



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(DateTerm)
class DateTermTests {

    void testCreate() {
       def date = new DateTerm()
       assert !date.validate()
       date = new DateTerm(text: "hoy", period: [new Date()])
       assert date.validate()
   	}

   	void testMatch() {
   		def date1 = new DateTerm(text: "mañana", period: [new Date() + 1])
   		assert date1.match([new Date()])
   		def date2 = new DateTerm(text: "en un día", period: [new Date() + 1])
   		def date3 = new DateTerm(text: "pasado mañana", period: [new Date() + 2])
   	}
}
