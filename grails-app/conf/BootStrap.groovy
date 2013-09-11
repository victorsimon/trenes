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
    }
    def destroy = {
    }
}
