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

grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
        excludes "xml-apis"
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        mavenLocal()
        grailsCentral()
        mavenCentral()
        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
        // runtime 'mysql:mysql-connector-java:5.1.38'
        // runtime 'org.postgresql:postgresql:9.4.1207.jre7'
         build ('org.jboss.tattletale:tattletale-ant:1.2.0.Beta2')  { excludes "ant", "javassist" }

        compile ('org.docx4j:docx4j:3.2.2') { excludes 'commons-logging:commons-logging:1.0.4', 'commons-codec', 'commons-io'}
        compile 'com.mchange:c3p0:0.9.5.2'
        compile 'mysql:mysql-connector-java:5.1.38'
        compile 'com.google.zxing:javase:3.2.1'
        compile ('org.codehaus.groovy.modules.http-builder:http-builder:0.7.1') { excludes "xercesImpl", "groovy",  "commons-lang", "commons-codec" }
        compile 'org.apache.commons:commons-email:1.4'
        
        //compile 'org.apache.httpcomponents:httpcore:4.4.4' -- (updated, should retry)
        compile 'org.apache.commons:commons-lang3:3.4'
	compile 'net.sourceforge.openutils:openutils-log4j:2.0.5'
        compile 'org.jadira.usertype:usertype.jodatime:2.0.1'
        compile 'com.unboundid:unboundid-ldapsdk:3.1.0'
                        
        //runtime ":resources:1.2.RC2"
        //runtime ":cached-resources:1.0"
        runtime 'org.springframework:spring-test:4.2.4.RELEASE'

        test ('org.codehaus.geb:geb-spock:0.7.2') { exclude 'spock' }
	test 'org.seleniumhq.selenium:selenium-firefox-driver:2.48.2'
        test ('net.sourceforge.htmlunit:htmlunit:2.19') { excludes "xml-apis" }
        test ('org.seleniumhq.selenium:selenium-htmlunit-driver:2.48.2')  { excludes "htmlunit" }
	test 'org.seleniumhq.selenium:selenium-chrome-driver:2.48.2'
	test 'org.seleniumhq.selenium:selenium-ie-driver:2.48.2'
        test 'org.seleniumhq.selenium:selenium-support:2.48.2'
        test 'dumbster:dumbster:1.6'
        test 'org.spockframework:spock-grails-support:0.7-groovy-2.0'
    }

    plugins {
        // plugins for the build system only
        build ":tomcat:7.0.53"

        // plugins for the compile step
        compile ':cache:1.1.2'
        compile ":rendering:0.4.4"
	compile ":raven:0.5.8"
        compile 'net.sf.barcode4j:barcode4j:2.1'
        compile 'org.codenarc:CodeNarc:0.24.1'
        compile 'org.grails.plugins:console:1.5.6'
        compile 'org.grails.plugins:csv:0.3.1'
        compile 'org.grails.plugins:dynamic-controller:0.5.1'
        compile 'org.grails.plugins:external-config-reload:1.4.1'
        compile 'org.webjars:famfamfam-silk:1.3-1'
        compile "org.grails.plugins:google-analytics:2.3.3"
        compile "org.grails.plugins:google-visualization:1.0.2"
        compile 'joda-time:joda-time:2.9.1'
        compile "org.grails.plugins:pretty-time:2.1.3.Final-1.0.1"
        

        // plugins needed at runtime but not for compilation
        runtime ":hibernate:3.6.10.15" // or ":hibernate4:4.3.5.2"
        runtime "org.grails.plugins:database-migration:1.4.1"
        runtime ":jquery:1.11.1"
        runtime ":resources:1.2.7"
        runtime( ':constraints:0.6.0' )
        runtime( ':jquery-validation:1.9' ) { excludes 'constraints' }
        runtime( ':jquery-validation-ui:1.4.7' ) { excludes 'constraints', 'spock' }
        
        //UPDATE: Spock is now included as a built in test runner as part of grails 2.3. 
        //If you migrate an app and leave the spock plugin then the default spock test 
        //runner will run the test, and then the plugin will too. 
        /* spock from the grails repo didn't work with grails 1.3, thus
           we've included our own build of it.
        test(name:'spock', version:'0.6') { exclude "spock-grails-support" }
        */
       
        runtime(':mail:1.0.6') { excludes 'mail', 'spring-test' }
        runtime(':excel-import:0.3') { excludes 'poi-contrib', 'poi-scratchpad' }
        runtime(':tomcat:7.0.53') 
        runtime(':external-config-reload:1.4.0') { exclude 'spock-grails-support' }
        runtime(':quartz2:2.1.6.2')
        runtime(":resources:1.1.6")
	runtime(":cache-headers:1.1.5")
        runtime(":jquery:1.7.2")
        runtime(":jquery-ui:1.8.7") { excludes 'jquery' }        
        
        test(name:'geb', version:'0.6.3') { }
        test ":code-coverage:1.2.5" //2.0.3-3
       
        // Uncomment these (or add new ones) to enable additional resources capabilities
        //runtime ":zipped-resources:1.0.1"
        //runtime ":cached-resources:1.1"
        //runtime ":yui-minify-resources:0.1.5"
        runtime(":zipped-resources:1.0.1") { excludes 'resources' }
        runtime(":cached-resources:1.1") { excludes 'resources', 'cache-headers' }
        
        // An alternative to the default resources plugin is the asset-pipeline plugin
        //compile ":asset-pipeline:1.6.1"

        // Uncomment these to enable additional asset-pipeline capabilities
        //compile ":sass-asset-pipeline:1.5.5"
        //compile ":less-asset-pipeline:1.5.3"
        //compile ":coffee-asset-pipeline:1.5.0"
        //compile ":handlebars-asset-pipeline:1.3.0.1"
    }
}
