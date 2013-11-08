define apache::mod_auth_cas {

  file { '/mod_auth_cas':
      ensure  => directory,
      ensure  => present,
      owner   => 'root',
      group   => 'root',
  }

  file { '/etc/httpd/certs/aws.cer':
        ensure    => file ,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
    }

   class{'apache':
    default_vhost => false,
   }

   apache::vhost {
        port    => '80'
        docroot => '/var/www/castest',
   }

   apache::vhost{
        port    => '443',
        docroot => '/var/www/castests',
        ssl     => true,
   }
}