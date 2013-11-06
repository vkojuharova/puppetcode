node default {

   tomcat::deployment { "castest":
      path => '/srv/puppetcode/wars/castest.war'
   }

   # repeat as desired for different servlets ...

}
