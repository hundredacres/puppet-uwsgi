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
    content => $uwsgi::manage_file_content,
    source  => $uwsgi::manage_file_source,
  }
  file { '/etc/sysconfig/uwsgi':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => $uwsgi::manage_ini_content,
    source  => $uwsgi::manage_ini_source,
  }
  file { '/etc/init.d/uwsgi':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => $uwsgi::manage_init_content,
    source  => $uwsgi::manage_init_source,
  }
  file { '/etc/logrotate.d/uwsgi':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/uwsgi/uwsgi.logrotate',
  }
  file { '/var/log/uwsgi.log':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0666',
  }
}
