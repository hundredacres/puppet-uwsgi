# == Class uwsgi::install
#
# This class is called from uwsgi for install.
#
class uwsgi::install {

  package { $::uwsgi::package_name:
    ensure => present,
  }
}
