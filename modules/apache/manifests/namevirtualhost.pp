define apache::namevirtualhost {
  $addr_port = $name
  include apache::params

#  file { $apache::params::ports_file:
#           ensure => file ,
#           content => template('apache/listen.erb'),
#           notify  => Class['Apache::Service'],
#           require => Package['httpd'],
#         }

# Do not use that . Imported to listen.erb
  # Template uses: $addr_port
#  concat::fragment { "NameVirtualHost ${addr_port}":
#    target  => $apache::params::ports_file,
#    content => template('apache/namevirtualhost.erb'),
#  }
}
