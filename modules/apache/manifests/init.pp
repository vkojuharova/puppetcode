class apache {
  include apache::install, apache::service

    notice("Establishing http://$name:80")
}







