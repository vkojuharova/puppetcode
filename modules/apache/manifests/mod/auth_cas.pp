class apache::mod::auth_cas {
    apache::mod { 'auth_cas': }

#Mod Auth CAS cache folder
    file { '/mod_auth_cas':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
    }

    file {  'auth_cas':
        ensure    => file,
        path      => "${mod_dir}/auth_cas.conf",
        content   => template ('apache/mod/auth_cas.conf.erb'),
        require   => Exec["mkdir ${apache::mod_dir}"],
        before    => File [$apache::mod_dir],
        notify    => Service['httpd'],

    }
    file {'mod_auth_cas.so':
        ensure  => file,
        path => "/usr/lib64/httpd/modules/mod_auth_cas.so",
#        path => "${confd_dir}/mod_auth_cas.so",
#        path    => "/etc/httpd/modules/mod_auth_cas.so",
        source  => 'puppet:///modules/apache/mod_auth_cas.so',
        group   => 'root',
        owner   => 'root',
        mode    => '0777',
        notify  => Service['httpd'],
    }
#    file { $httpd_conf:
#        ensure    => file ,
#          source  => 'puppet:///modules/apache/httpd.conf',
#          owner   => 'root',
#          group   => 'root',
#          mode    => '0644',
#          require => Package[$httpd_pkg],
#    }
    notice("AUTH_CAS DEBUG: Servername is ${servername}")
    notice("AUTH_CAS DEBUG: Name is ${name}")
    notice("AUTH_CAS DEBUG: Host is ${hostname}")
    notice("AUTH_CAS DEBUG: FQDN is ${fqdn}")
    notice("AUTH_CAS DEBUG: DNS name is ${dns_name}")
    notice("AUTH_CAS DEBUG: Instance id is ${instance-id}")
    notice("AUTH_CAS DEBUG: Public hostname is ${public-hostname}")
    apache::vhost{'mod_auth_cas_host':
        vhost_name => "${servername}",
        ensure  => $default_ssl_vhost_ensure,
        port    => '443',
        serveradmin     => 'vanja_kojuharova@harvard.edu',
        access_log_file => "castest_${access_log_file}",
        priority        => '15',
        docroot => '/var/www/castest',
        ssl     => true,
        mod_auth_cas => true,
#        proxy_pass => false,
#        proxy_dest => "castest ajp://$name:8003/castest"
    }
}
