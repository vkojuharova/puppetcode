class apache::mod::mod_auth_cas {
  apache::mod { 'mod_auth_cas': }

  file {  'auth_cas_module':
  ensure    => file,
  path      => "${apache::mod_dir}/auth_cas.conf",
  content   => template ('apache/mod/auth_cas.conf.erb'),
  require   => Exec["mkdir ${apache::mod_dir}"],
  before    => File [$apache::mod_dir],
  notify    => Service['httpd'],

  }
}
