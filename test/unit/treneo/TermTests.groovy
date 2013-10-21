package treneo



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Term)
class TermTests {

    void testConstraints() {
		def term = new Term()
		assert !term.validate() //text blank
		term = new Term(text: "Termino").save(flush: true)
		assert term.validate()
		assert term.text
    }

    void testNormalized() {
		def term = new Term(text: "Termino").save(flush: true)
		def normalized = term.normalized
		assert normalized == "termino"
    }

    void testMultiWordNormalized() {
		def term = new Term(text: "Termino   comPlejo  y muy      largo").save(flush: true)
		def normalized = term.normalized
		assert normalized == "termino complejo y muy largo"
    }

    void testWords() {
		def term = new Term(text: "Termino   comPlejo  y muy      largo").save(flush: true)
		assert term.words == 5
    }

    void testMatch() {
		def term = new Term(text: "   Termino   UNO    ").save(flush: true)
		assert term.match("termino uno")
		def other = new Term(text: "termino uno").save(flush: true)
		assert term.match(other)
    }

    void testInside() {
		def term = new Term(text: "   Termino   UNO    ").save(flush: true)
		assert !term.inside("")
		assert term.inside(" esto contiene termino uno")
		def other = new Term(text: "termino uno").save(flush: true)
		assert term.inside(other)
		other = new Term(text: "termino").save(flush: true)
		assert !term.inside(other)
    }
}
