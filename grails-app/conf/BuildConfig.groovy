grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
        mavenRepo "http://repository.springsource.com/maven/bundles/release/"
        mavenRepo "http://repository.springsource.com/maven/bundles/external/"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.

        runtime 'mysql:mysql-connector-java:5.1.22'

        compile 'xerces:xercesImpl:2.9.1',
               'net.sourceforge.nekohtml:nekohtml:1.9.15'

    }

    plugins {
        runtime ":hibernate:3.6.10.2"
        runtime ":jquery:1.10.2"
        runtime ":resources:1.2"

        // Uncomment these (or add new ones) to enable additional resources capabilities
        runtime ":zipped-resources:1.0"
        compile ":cache-headers:1.1.5"
        runtime (":cached-resources:1.0") {
            exclude "resources"
        }
        //runtime ":yui-minify-resources:0.1.5"

        build ":tomcat:7.0.42"

        runtime ":database-migration:1.3.5"

        compile ':cache:1.1.1'

        //Especificos
        /*compile (":kickstart-with-bootstrap:0.9.6") {
            exclude "resources"
            exclude "jquery"
        }*/
        compile ":lesscss-resources:1.3.3"
        compile ":font-awesome-resources:3.2.1.2"
        
        compile ":gpars:0.3"
        //compile ":searchable:0.6.4"
    }
}
