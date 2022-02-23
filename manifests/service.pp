# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include my_webapp::service
class my_webapp::service {

  service { $my_webapp::web_service:
    ensure => $my_webapp::http_ensure,
    enable => $my_webapp::http_enable,
  }
}
