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

   apache::vhost{'mod_auth_cas_host':
        ensure  => $default_ssl_vhost_ensure,
        port    => '8005',
        serveradmin     => 'vanja_kojuharova@harvard.edu',
        access_log_file => "castest_${access_log_file}",
        priority        => '15',
        docroot => '/var/www/castests',
        ssl     => true,
        mo_auth_cas => true,
   }
}