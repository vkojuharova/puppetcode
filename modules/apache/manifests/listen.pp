define apache::listen {
  $listen_addr_port = $name
  include apache::params


   file { "ports.conf":
         ensure => present ,
         path    => "$apache::params::ports_file",
         content => 'puppet:///modules/apache/listen.erb' ,
         replace => true,
         notify  => Class['Apache::Service'],
         require => Package['httpd'],
  }
# Template uses: $listen_addr_port
#  concat::fragment { "Listen ${listen_addr_port}":
#    target  => $apache::params::ports_file,
#    content => template('apache/listen.erb'),
#  }
}
