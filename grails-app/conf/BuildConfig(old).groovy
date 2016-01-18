/**
* Copyright (c) 2012 Partners In Health.  All rights reserved.
* The use and distribution terms for this software are covered by the
* Eclipse Public License 1.0 (http://opensource.org/licenses/eclipse-1.0.php)
* which can be found in the file epl-v10.html at the root of this distribution.
* By using this software in any fashion, you are agreeing to be bound by
* the terms of this license.
* You must not remove this notice, or any other, from this software.
**/ 
//grails.server.port.http = 8081

grails.project.class.dir = "target/classes"
grails.project.docs.output.dir = "web-app/docs"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.plugin.location.spock='spock/'
grails.plugin.location.liquibase='liquibase/'

// Development configuration property used to enable xrebel features
//grails.tomcat.jvmArgs = ["-javaagent:/home/jmiranda/Desktop/xrebel/xrebel.jar"]

grails.project.dependency.resolution = {
	// inherit Grails' default dependencies
	inherits( "global" ) {
		// uncomment to disable ehcache
		// excludes 'ehcache'
		excludes "xml-apis"
	}
	log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
	repositories {
		//grailsRepo "http://grails.org/plugins"
		grailsPlugins()
		grailsHome()
		grailsCentral()

		mavenLocal()
		mavenCentral()

        mavenRepo "http://repo.grails.org/grails/plugins-releases/"
        mavenRepo "http://repo.grails.org/grails/plugins/"
	}
	
	dependencies {
        //build ('org.jboss.tattletale:tattletale-ant:1.2.0.Beta2')  { excludes "ant", "javassist" }

        compile ('org.docx4j:docx4j:2.8.1') { excludes 'commons-logging:commons-logging:1.0.4', 'commons-codec', 'commons-io'}
        compile 'c3p0:c3p0:0.9.1.2'
        compile 'mysql:mysql-connector-java:5.1.26'

        compile 'com.google.zxing:javase:2.0'
        compile ('org.codehaus.groovy.modules.http-builder:http-builder:0.6') { excludes "xercesImpl", "groovy",  "commons-lang", "commons-codec" }
        compile 'org.apache.commons:commons-email:1.2'
        //compile 'org.apache.httpcomponents:httpcore:4.2.1'
        compile 'commons-lang:commons-lang:2.6'
		compile 'net.sourceforge.openutils:openutils-log4j:2.0.5'
        compile "org.jadira.usertype:usertype.jodatime:1.9"

        compile "com.unboundid:unboundid-ldapsdk:2.3.6"
        //runtime ":resources:1.2.RC2"
        //runtime ":cached-resources:1.0"

        runtime 'org.springframework:spring-test:3.0.5.RELEASE'

        test ("org.codehaus.geb:geb-spock:0.6.3") {
            exclude 'spock'
        }
		test 'org.seleniumhq.selenium:selenium-firefox-driver:2.25.0'
        test ('net.sourceforge.htmlunit:htmlunit:2.10') { excludes "xml-apis" }
        test ('org.seleniumhq.selenium:selenium-htmlunit-driver:2.25.0')  { excludes "htmlunit" }
		test 'org.seleniumhq.selenium:selenium-chrome-driver:2.25.0'
		test 'org.seleniumhq.selenium:selenium-ie-driver:2.25.0'
        test 'org.seleniumhq.selenium:selenium-support:2.25.0'
		test 'dumbster:dumbster:1.6'
        test "org.spockframework:spock-grails-support:0.6-groovy-1.7"


	}
	plugins {

		compile ":rendering:0.4.4"
		compile ":raven:0.5.8"

		runtime( ':constraints:0.6.0' )
        runtime( ':jquery-validation:1.9' ) { // 1.7.3
            excludes 'constraints'
        }
        runtime( ':jquery-validation-ui:1.4.7' ) { // 1.1.1
            excludes 'constraints', 'spock'
        }
        /* spock from the grails repo doesn't work with grails 1.3
           we've included our own build of it.
        test(name:'spock', version:'0.6')
        */
        //runtime(":liquibase:1.9.3.6") { excludes 'data-source' }
        runtime(':mail:1.0.6') { excludes 'mail', 'spring-test' }
        runtime(':excel-import:0.3') { excludes 'poi-contrib', 'poi-scratchpad' }
        runtime(':hibernate:1.3.9') { excludes 'antlr' }
        runtime(':tomcat:1.3.9') 
        runtime(':external-config-reload:1.4.0') { exclude 'spock-grails-support' }
        runtime(':quartz2:2.1.6.2')
        runtime(":resources:1.1.6")
		runtime(":cache-headers:1.1.5")
        runtime(":zipped-resources:1.0") { excludes 'resources' }
        runtime(":cached-resources:1.0") { excludes 'resources', 'cache-headers' }
        runtime(":jquery:1.7.2")
        runtime(":jquery-ui:1.8.7") { excludes 'jquery' }

        //test(":spock:0.6") {
        //    exclude "spock-grails-support"
        //}
        test(name:'geb', version:'0.6.3') { }
        test ":code-coverage:1.2.5" //2.0.3-3

        // Dependencies that we want to use but cannot due to errors
        //compile ":standalone:1.0"
        //compile ":burning-image:0.5.1"
        //compile ":settings:1.4"
        //compile ":symmetricds:2.4.0"
        //compile ":grails-melody:1.46"

	}
}
