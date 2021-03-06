# == Class uwsgi::plugin
#
# This class is called from uwsgi for installing plugins.
#
define uwsgi::plugin(
  $ensure = 'present',
) {

  package { "uwsgi-plugin-${name}":
    ensure => $ensure,
  }
}
