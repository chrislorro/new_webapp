# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include my_webapp
class my_webapp (
  String               $pkg_version,
  String               $app_user,
  String               $web_package,
  String               $web_service,
  String               $svc_owner,
  String               $http_config,
  Integer              $websvc_port,
  Boolean              $http_enable,
  Hash                 $websvc_users,
  Stdlib::IP::Address  $listen_ip,
  Stdlib::Absolutepath $config_path,
  Enum['stopped',
      'running']       $http_ensure,
  Optional[Boolean]    $ensure_vhost = undef,
  Optional[String[1]]  $servicename  = undef,
){

  contain my_webapp::install
  contain my_webapp::config
  contain my_webapp::service

  Class['my_webapp::install']
  -> Class['my_webapp::config']
  ~> Class['my_webapp::service']

}
