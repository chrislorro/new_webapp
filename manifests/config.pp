# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include my_webapp::config
class my_webapp::config {

  $app_users = lookup('my_webapp::websvc_users')
  $app_user_defaults = lookup('my_webapp::websvc_user_defaults')

  $app_users.each |$user, $config| {
    user { $user:
      * => $app_user_defaults + $config,
    }
  }

  $http_config = "${my_webapp::config_path}/${my_webapp::http_config}"

  file { $http_config:
    ensure  => present,
    mode    => '0644',
    owner   => $my_webapp::app_user,
    require => Class['my_webapp::install']
  }

  if my_webapp::ensure_vhost {
    case $facts['kernel'] {
      default: {
        warning("Apache not supported on ${facts['kernel']}")
      }
      'Linux': {
        $default_vhost_file = $my_webapp::servicename ? {
          String  => "${my_webapp::config_path}/${my_webapp::servicename}.conf",
          default => fail('If ensure_vhost is set to true, then servicename needs to be set!'),
        }
        my_webapp::virtual_svc { "${my_webapp::servicename}.conf":
          vhost_path  => $default_vhost_file,
          listen_ip   => $my_webapp::listen_ip,
          websvc_port => $my_webapp::websvc_port,
          servicename => $my_webapp::servicename
        }
      }
    }
  }
}
