class apache {
  package { 'httpd':
    ensure => present,
  }
  file { '/etc/httpd/conf/httpd.conf':
    ensure    => file ,
      source  => 'puppet:///modules/apache/httpd.conf',
      owner   => 'apache',
      group   => 'apache',
      mode    => '0644',
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
    subscribe => File ['/etc/httpd/conf/httpd.conf'] ,
 }
}
