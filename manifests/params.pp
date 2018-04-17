# == Class uwsgi::params
#
# This class is meant to be called from uwsgi.
# It sets variables according to platform.
#
class uwsgi::params {
  $config_source = undef
  $config_template = 'uwsgi/uwsgi.ini.erb'
  $ini_source = undef
  $ini_template = 'uwsgi/uwsgi.sysconfig.erb'
  $init_source = undef
  $init_template = 'uwsgi/uwsgi.initd.erb'
  $logrotate_source = 'puppet:///modules/uwsgi/uwsgi.logrotate'

  case $::osfamily {
    'Debian': {
      $package_name = 'uwsgi'
      $service_name = 'uwsgi'
    }
    'RedHat', 'Amazon': {
      $package_name = 'uwsgi'
      $service_name = 'uwsgi'
      case $::lsbmajdistrelease {
        6: {
          $sysconfig_uwsgi = 'present'
        }
        7: {
          $sysconfig_uwsgi = 'absent'
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
