# == Class uwsgi::service
#
# This class is meant to be called from uwsgi.
# It ensure the service is running.
#
class uwsgi::service {

  service { $::uwsgi::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
