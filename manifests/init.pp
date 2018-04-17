# Class: uwsgi
# ===========================
#
# Full description of class uwsgi here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class uwsgi (
  $config_source      = $::uwsgi::params::config_source,
  $config_template    = $::uwsgi::params::config_template,
  $ini_source         = $::uwsgi::params::ini_source,
  $ini_template       = $::uwsgi::params::ini_template,
  $init_source        = $::uwsgi::params::init_source,
  $init_template      = $::uwsgi::params::init_template,
  $logrotate_source   = $::uwsgi::params::logrotate_source,
  $package_name       = $::uwsgi::params::package_name,
  $service_name       = $::uwsgi::params::service_name,
) inherits ::uwsgi::params {

  # validate parameters here
  $manage_file_source = $uwsgi::config_source ? {
    ''        => undef,
    default   => $uwsgi::config_source,
  }

  $manage_file_content = $uwsgi::config_template ? {
    ''        => undef,
    default   => template($uwsgi::config_template),
  }

  $manage_ini_source = $uwsgi::ini_source ? {
    ''        => undef,
    default   => $uwsgi::ini_source,
  }

  $manage_ini_content = $uwsgi::ini_template ? {
    ''        => undef,
    default   => template($uwsgi::ini_template),
  }

  $manage_init_source = $uwsgi::init_source ? {
    ''        => undef,
    default   => $uwsgi::init_source,
  }

  $manage_init_content = $uwsgi::init_template ? {
    ''        => undef,
    default   => template($uwsgi::init_template),
  }

  class { '::uwsgi::install': } ->
  class { '::uwsgi::config': } ~>
  class { '::uwsgi::service': } ->
  Class['::uwsgi']
}
