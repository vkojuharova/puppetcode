# Currently not used
define apache::listen {
  $listen_addr_port = $name
  include apache::params


   file { "$apache::params::ports_file":
         ensure  => present ,
         ensure  => file,
         path    => "$apache::params::ports_file",
         content => 'puppet:///modules/apache/listen.erb' ,
         owner   => "root",
         group   => "root",
         mode    => 0644,
         replace => true,
         once    => true,
         notify  => Class['Apache::Service'],
         require => Package['httpd'],
  }
# Template uses: $listen_addr_port
#  concat::fragment { "Listen ${listen_addr_port}":
#    target  => $apache::params::ports_file,
#    content => template('apache/listen.erb'),
#  }
}
