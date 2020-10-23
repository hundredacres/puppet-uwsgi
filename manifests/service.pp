# == Class uwsgi::service
#
# This class is meant to be called from uwsgi.
# It ensure the service is running.
#
class uwsgi::service {

  if ($::uwsgi::manage_service_file) {
    $service_file = $::service_provider ? {
      redhat  => '/etc/init.d/uwsgi',
      upstart => '/etc/init/uwsgi.conf',
      systemd => '/usr/lib/systemd/system/uwsgi.service',
      default => '/etc/init/uwsgi.conf',
    }
  }
  file { $service_file:
    ensure  => $::uwsgi::sysconfig_uwsgi,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => $::uwsgi::manage_service_content,
    source  => $::uwsgi::manage_service_source,
    require => $::uwsgi::package_name,
  }
  if $service_provider == 'systemd' {
    exec { 'uwsgi-reload-systemd':
      command     => '/bin/systemctl daemon-reload',
      refreshonly => true,
      subscribe   => File[$::uwsgi::service_file],
      before      => Service[$::uwsgi::service_name],
    }
  }
  service { $::uwsgi::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    restart    => 'service uwsgi reload',
  }
}
