node default {

   tomcat::deployment { "castest":
      path => '/srv/puppet-tomcat-demo/wars/castest.war'
   }

   # repeat as desired for different servlets ...

}
