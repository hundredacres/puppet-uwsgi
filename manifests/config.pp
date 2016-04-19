# == Class uwsgi::config
#
# This class is called from uwsgi for service config.
#
class uwsgi::config {
  file { '/etc/uwsgi.ini':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => $uwsgi::config_template,
    source  => $uwsgi::config_source,
  }
  file { '/var/log/uwsgi.log':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
  }
}
