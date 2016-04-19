# == Class uwsgi::params
#
# This class is meant to be called from uwsgi.
# It sets variables according to platform.
#
class uwsgi::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'uwsgi'
      $service_name = 'uwsgi'
    }
    'RedHat', 'Amazon': {
      $package_name = 'uwsgi'
      $service_name = 'uwsgi'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
