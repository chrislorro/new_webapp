# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   my_webapp::virtual_svc { 'namevar': }
define my_webapp::virtual_svc (
  String $vhost_path   = $vhost_path,
  String $listen_ip    = $listen_ip,
  String $servicename  = $servicename,
  Integer $websvc_port = $websvc_port,
) {

  $svc_owner = lookup('my_webapp::svc_owner')

  file { $title:
    ensure  => present,
    path    => $vhost_path,
    mode    => '0640',
    content => epp('my_webapp/web_svc.conf.epp', {
      'listen_ip'   => $listen_ip,
      'websvc_port' => $websvc_port,
      'servicename' => $servicename,
      }),
    owner   => $svc_owner,
  }
}
