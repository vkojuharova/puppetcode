class apache {
  package { 'httpd':
    ensure => present,
  }
  file { '/etc/https/conf/httpd.conf':
    ensure    => file ,
      owner   => 'root',
      group   => 'root',
      require => Package['httpd'],
  }
  file { '/var/www':
    ensure => directory,
  }
  file { '/var/www/html':
    ensure => directory,
  }
  file { '/var/www/html/index.html':
    ensure => file ,
    source => 'puppet:///modules/apache/index.html',
  }
  service { 'httpd':
    ensure    => running,
    susbscibe => File ['/etc/httpd/conf/httpd.conf'] ,
 }
}
