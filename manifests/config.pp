# == Class uwsgi::config
#
# This class is called from uwsgi for service config.
#
class uwsgi::config {
  file { '/etc/uwsgi.ini':
    ensure  => $::uwsgi::file_ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => $::uwsgi::manage_file_content,
    source  => $::uwsgi::manage_file_source,
  }
  file { '/etc/sysconfig/uwsgi':
    ensure  => $::uwsgi::sysconfig_uwsgi,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => $::uwsgi::manage_ini_content,
    source  => $::uwsgi::manage_ini_source,
  }
  file { '/etc/logrotate.d/uwsgi':
    ensure  => $::uwsgi::sysconfig_uwsgi,
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
