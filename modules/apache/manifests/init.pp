class apache {
  case $::osfamily {
    'RedHat': {
      $httpd_user = 'apache'
      $httpd_group ='apache'
      $httpd_pkg   ='httpd'
      $httpd_svc   ='httpd'
      $httpd_conf  ='/etc/httpd/conf/httpd.conf'
      $httpd_conf_dot_d  ='/etc/httpd/conf.d'
    }
    'Debian': { 
     $httpd_user = 'www-data'
     $httpd_group= 'www-data'
     $httpd_pkg  = 'apache2'
     $httpd_svc  = 'apache2'
     $httpd_conf = '/etc/apache2/conf/httpd.conf'
     $httpd_conf = '/etc/apache2/conf.d'
    }
    default : {
      fail("Module ${module_name}is not supported on ${::osfamily}")
    }
  }

  $auth_cas_apache_port=8005
  $apache_httpd_log_level = debug
  $apache_httpd_doc_root='/usr/www/html'
  $apache_error_log='logs/error_log'
  $apache_www_home='/var/www'

  File {
   owner => $httpd_user,
   group => $httpd_group,
   mode  => '0644',
  }
  package { $httpd_pkg:
        ensure => present,
  }
  file { $httpd_conf:
    ensure    => file ,
      source  => 'puppet:///modules/apache/httpd.conf',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package[$httpd_pkg],
  }
  file { '/var/www':
    ensure => directory,
  }
  file { '/var/www/html':
    ensure => directory,
  }
  file { '/var/www/html/index.html':
    ensure => file ,
    content =>template('apache/index.html.erb'),
  }
  service { $httpd_svc:
    ensure    => running,
    subscribe => File [$httpd_conf] ,
 }
}

