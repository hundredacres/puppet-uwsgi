# == Class uwsgi::params
#
# This class is meant to be called from uwsgi.
# It sets variables according to platform.
#
class uwsgi::params {
  $config_source       = undef
  $config_template     = 'uwsgi/uwsgi.ini.erb'
  $ini_source          = undef
  $ini_template        = 'uwsgi/uwsgi.sysconfig.erb'
  $service_source      = undef
  $service_template    = 'uwsgi/uwsgi.initd.erb'
  $service_template = $::service_provider ? {
    redhat  => 'uwsgi/uwsgi.init.erb',
    upstart => 'uwsgi/uwsgi.upstart.conf.erb',
    systemd => 'uwsgi/uwsgi.systemd.erb',
    default => 'uwsgi/uwsgi.upstart.conf.erb',
  }
  $package_ensure      = 'installed'
  $service_ensure      = true
  $service_enable      = true
  $manage_service_file = true
  $logrotate_source = 'puppet:///modules/uwsgi/uwsgi.logrotate'

  # remove config files if package is purged
  $file_ensure = $package_ensure ? {
    'absent' => 'absent',
    'purged' => 'absent',
    default  => 'present'
  }
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
