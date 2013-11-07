define apache::mod_auth_cas {

  file { '/mod_auth_cas':
      ensure  => directory,
      ensure  => present,
      owner   => 'root',
      group   => 'root',
  }

  file { '/etc/httpd/certs':
        ensure    => file ,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }

}