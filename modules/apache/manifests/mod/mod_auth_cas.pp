class apache::mod::mod_auth_cas {
    apache::mod { 'mod_auth_cas': }

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

    file {  'auth_cas_module':
        ensure    => file,
        path      => "${$mod_dir}/auth_cas.conf",
        content   => template ('apache/mod/auth_cas.conf.erb'),
        require   => Exec["mkdir ${apache::mod_dir}"],
        before    => File [$apache::mod_dir],
        notify    => Service['httpd'],

    }
    file {'mod_auth_cas.so':
        ensure  => file,
        path    => "${apache::params::mod_libs}",
        source  => 'puppet:///modules/apache/modules/mod_ath_cas.so'
        group   => 'root',
        owner   => 'root',
        mode    => '0644',
        notify  => Service['httpd'],
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
