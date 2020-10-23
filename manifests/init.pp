# Class: uwsgi
# ===========================
#
# Full description of class uwsgi here.
#
# Parameters
# ----------
#
# * `config_source`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# * `package_ensure`
#
# * `package_name`
#
class uwsgi (
  $config_source       = $::uwsgi::params::config_source,
  $config_template     = $::uwsgi::params::config_template,
  $ini_source          = $::uwsgi::params::ini_source,
  $ini_template        = $::uwsgi::params::ini_template,
  $service_source         = $::uwsgi::params::service_source,
  $service_template       = $::uwsgi::params::service_template,
  $package_name        = $::uwsgi::params::package_name,
  $package_ensure      = $::uwsgi::params::package_ensure,
  $service_name        = $::uwsgi::params::service_name,
  $service_ensure      = $::uwsgi::params::service_ensure,
  $service_enable      = $::uwsgi::params::service_enable,
  $manage_service_file = $::uwsgi::params::manage_service_file,
  $file_ensure         = $::uwsgi::params::file_ensure,
  $logrotate_source   = $::uwsgi::params::logrotate_source,
) inherits ::uwsgi::params {

  # validate parameters here
  $manage_file_source = $::uwsgi::config_source ? {
    ''        => undef,
    default   => $::uwsgi::config_source,
  }

  $manage_file_content = $::uwsgi::config_template ? {
    ''        => undef,
    default   => template($::uwsgi::config_template),
  }

  $manage_ini_source = $::uwsgi::ini_source ? {
    ''        => undef,
    default   => $::uwsgi::ini_source,
  }

  $manage_ini_content = $::uwsgi::ini_template ? {
    ''        => undef,
    default   => template($::uwsgi::ini_template),
  }

  $manage_service_source = $::uwsgi::service_source ? {
    ''        => undef,
    default   => $::uwsgi::service_source,
  }

  $manage_service_content = $::uwsgi::service_template ? {
    ''        => undef,
    default   => template($::uwsgi::service_template),
  }

  class { '::uwsgi::install': } ->
  class { '::uwsgi::config': } ~>
  class { '::uwsgi::service': } ->
  Class['::uwsgi']
}
