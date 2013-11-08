node default {

   tomcat::deployment { "castest":
      path => '/srv/puppetcode/wars/castest.war'
   }

include apache

#define apache::vhost(

#)

}
