class apache::install {
#        package {["httpd"]:
#        ensure  => present,
#    }



      package { 'httpd':
        ensure => $package_ensure,
        name   => $apache::params::apache_name,
        notify => Class['Apache::Service'],
      }


}