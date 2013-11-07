class apache {
  include apache::install, apache::service
}

define apache::install {

  include apache
  notice("Establishing http://$name:80")
}

