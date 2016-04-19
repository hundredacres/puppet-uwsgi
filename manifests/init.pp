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
  $package_name = $::uwsgi::params::package_name,
  $service_name = $::uwsgi::params::service_name,
) inherits ::uwsgi::params {

  # validate parameters here

  class { '::uwsgi::install': } ->
  class { '::uwsgi::config': } ~>
  class { '::uwsgi::service': } ->
  Class['::uwsgi']
}
