class apache::params {
#    $osr_array = split ($:: operatingsystemrelease, '[\/\.]')
#    $distrelease = $osr_array[0]
#    if !$distrelease {
#    fail (" Class['apache::params']: Unparsable \$::operatingsystemrelease:  $ {:: operatingsystemrelease} ")
#    }

    if ($::fqdn) {
        $servername = $::fqdn
    } else {
        $servername = $::hostname
    }

    notice("Hostname $hostname")
    notice("Servername $servername")
    notice("Osfamily $osfamily")
    notice("operatingsystem $operatingsystem")
    notice("fqdn is $fqdn")

    $conf_template        = 'apache/httpd.conf.erb'

    if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon'
    {
        $user = 'apache'
        $group = 'apache'
        $root_group = 'root'
        $apache_name = 'httpd'
        $service_name = 'httpd'
        $httpd_dir = '/etc/httpd'
        $conf_dir = "${httpd_dir}/conf"
        $confd_dir = "${httpd_dir}/conf.d"
        $mod_dir = "${httpd_dir}/conf.d"
        $vhost_dir = "${httpd_dir}/conf.d"
        $conf_file = 'httpd.conf'
        $ports_file = "${conf_dir}/ports.conf"
        $logroot = '/var/log/httpd'
        $lib_path = 'modules'
        $mpm_module = 'prefork'
#       $dev_packages = 'httpd-devel'
        $default_ssl_cert = '/etc/pki/tls/certs/localhost.crt'
        $default_ssl_key = '/etc/pki/tls/private/localhost.key'
        $ssl_certs_dir = '/etc/pki/tls/certs'
        $mod_packages         = {
              'auth_kerb'   => 'mod_auth_kerb',
              'authnz_ldap' => 'mod_authz_ldap',
              'fastcgi'     => 'mod_fastcgi',
              'fcgid'       => 'mod_fcgid',
              'passenger'   => 'mod_passenger',
              'perl'        => 'mod_perl',
              'php5'        => $distrelease ? {
                '5'     => 'php53',
                default => 'php',
              },
              'proxy_html'  => 'mod_proxy_html',
              'python'      => 'mod_python',
              'shibboleth'  => 'shibboleth',
              'ssl'         => 'mod_ssl',
              'wsgi'        => 'mod_wsgi',
              'dav_svn'     => 'mod_dav_svn',
              'suphp'       => 'mod_suphp',
              'xsendfile'   => 'mod_xsendfile',
            }
            $mod_libs             = {
              'php5' => 'libphp5.so',
            }

        $keepalive            = 'Off'
        $keepalive_timeout    = 15
        $fastcgi_lib_path     = undef
    }  elsif $::osfamily == 'Debian' {
        $user             = 'www-data'
        $group            = 'www-data'
        $root_group       = 'root'
        $apache_name      = 'apache2'
        $service_name     = 'apache2'
        $httpd_dir        = '/etc/apache2'
        $conf_dir         = $httpd_dir
        $confd_dir        = "${httpd_dir}/conf.d"
        $mod_dir          = "${httpd_dir}/mods-available"
        $vhost_dir        = "${httpd_dir}/sites-available"
        $conf_file        = 'apache2.conf'
        $ports_file       = "${conf_dir}/ports.conf"
        $logroot          = '/var/log/apache2'
        $lib_path         = '/usr/lib/apache2/modules'
        $mpm_module       = 'worker'
#       $dev_packages     = ['libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev']
        $default_ssl_cert = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
        $default_ssl_key  = '/etc/ssl/private/ssl-cert-snakeoil.key'
        $ssl_certs_dir    = '/etc/ssl/certs'
        $mod_packages     = {
              'auth_kerb'   => 'libapache2-mod-auth-kerb',
              'authnz_ldap' => 'libapache2-mod-authz-ldap',
              'fastcgi'     => 'libapache2-mod-fastcgi',
              'fcgid'       => 'libapache2-mod-fcgid',
              'passenger'   => 'libapache2-mod-passenger',
              'perl'        => 'libapache2-mod-perl2',
              'php5'        => 'libapache2-mod-php5',
              'proxy_html'  => 'libapache2-mod-proxy-html',
              'python'      => 'libapache2-mod-python',
              'wsgi'        => 'libapache2-mod-wsgi',
              'dav_svn'     => 'libapache2-svn',
              'suphp'       => 'libapache2-mod-suphp',
              'xsendfile'   => 'libapache2-mod-xsendfile',
            }
            $mod_libs         = {
              'php5' => 'libphp5.so',
            }
            $keepalive         = 'Off'
            $keepalive_timeout = 15
            $fastcgi_lib_path  = '/var/lib/apache2/fastcgi'
    } else {
        fail("Class['apache::params']: Unsupported osfamily: ${::osfamily}")
    }
}