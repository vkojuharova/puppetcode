define apache::vhost (
      $docroot,
      $port       = '80',
      $priority   = '10',
      $options    = 'Indexes MultiViews',
      $vhost_name = $name,
      $servername = $name,
      $logdir     = '/var/log/httpd',
 ) {
  if ! defined (Class['apache']) {
    fail('you must include the apache class',
    'before declaring apache::vhost resources')
  }
    file { "/etc/httpd/conf.d/${name}.conf":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('apache/vhost.erb'),
      notify  => Service[$apache::service],
      require => Package[$apache::package],
    }
 }
