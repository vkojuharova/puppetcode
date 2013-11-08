class apache :: params {
    $osr_array = split ($:: operatingsystemrelease, '[\/\.]')
    $distrelease = $osr_array[0]
    if !$distrelease {
    fail (" Class['apache::params']: Unparsable \$::operatingsystemrelease:  $ {:: operatingsystemrelease} ")
    }

    if ($:: fqdn) {
        $servername = $:: fqdn
    } else {
        $servername = $:: hostname
    }

    if $:: osfamily == 'RedHat' or $:: operatingsystem == 'amazon' {
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
#        $mpm_module = 'prefork'
#       $dev_packages = 'httpd-devel'
        $default_ssl_cert = '/etc/pki/tls/certs/localhost.crt'
        $default_ssl_key = '/etc/pki/tls/private/localhost.key'
        $ssl_certs_dir = '/etc/pki/tls/certs'
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
#       $dev_packages     = ['libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev']
        $default_ssl_cert = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
        $default_ssl_key  = '/etc/ssl/private/ssl-cert-snakeoil.key'
        $ssl_certs_dir    = '/etc/ssl/certs'

    } else {
        fail("Class['apache::params']: Unsupported osfamily: ${::osfamily}")
    }
}