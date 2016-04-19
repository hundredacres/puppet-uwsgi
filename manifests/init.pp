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
  $config_source   = $::uwsgi::params::config_source,
  $config_template = $::uwsgi::params::config_template,
  $package_name    = $::uwsgi::params::package_name,
  $service_name    = $::uwsgi::params::service_name,
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

  class { '::uwsgi::install': } ->
  class { '::uwsgi::config': } ~>
  class { '::uwsgi::service': } ->
  Class['::uwsgi']
}
