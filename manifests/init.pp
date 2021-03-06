# == Class: kibana
# ===========================
#
#
# Description of the Class:
#
#   Install and configure kibana frontend for the elasticsearch service
#      which is providing access to real time data
#
#
# Document all Parameters:
#
#   Explanation of what this parameter affects and what it defaults to.
#   version                      = Kibana4 version to install
#   repo_version                 = Kibana4 repo version
#   package_name                 = the Kibana4 package name
#   elastic_cluster              = the Name of the elastic cluster
#   elastic_instance             = the instance Name of the elastic cluster
#   elastic_vip                  = the vip Name of the elastic cluster
#   elastic_vip_ip               = the vip IP of the elastic cluster
#   elastic_url                  = the url of the elastic cluster
#   elastic_cert                 = full path of the elastic certificate
#   elastic_key                  = full path of the elastic key
#   elastic_password             = elastic search password
#   elastic_username             = elastic search username
#   kibana_server                = kibana server address
#   kibana_server_ip             = kibana server IP address
#   kibana_port                  = kibana local port
#   kibana_index                 = default kibana index
#   kibana_defaultAppId          = default kibaba app
#   kibana_pidfile               = pid file and path
#   kibana_logfile               = log file and path
#   elastic_verify               = boolean ssl verify setting
#   elastic_ca                   = to set if openssl verify is not automatic
#   server_key                   = full path of the kibana key
#   server_cert                  = full path of the kibana certificate
#   tmpfile                      = file for system start procedure creating tmp directories
#
#
# ===========================
#
#
# == Authors
# ----------
#
# Author: Addi <addi.abel@gmail.com>
#
#
# == Copyright
# ------------
#
# Copyright:  ©  2016  LR / Addi.
#
#
class kibana (
  $version             = $kibana::params::version,
  $repo_version        = $kibana::params::repo_version,
  $package_name        = $kibana::params::package_name,
  $service_ensure      = $kibana::params::service_ensure,
  $elastic_cluster     = $kibana::params::elastic_cluster,
  $elastic_instance    = $kibana::params::elastic_instance,
  $elastic_vip         = $kibana::params::elastic_vip,
  $elastic_vip_ip      = $kibana::params::elastic_vip_ip,
  $elastic_url         = $kibana::params::elastic_url,
  $elastic_cert        = $kibana::params::elastic_cert,
  $elastic_key         = $kibana::params::elastic_key,
  $elastic_password    = $kibana::params::elastic_password,
  $elastic_username    = $kibana::params::elastic_username,
  $kibana_server       = $kibana::params::kibana_server,
  $kibana_server_ip    = $kibana::params::kibana_server_ip,
  $kibana_port         = $kibana::params::kibana_port,
  $kibana_index        = $kibana::params::kibana_index,
  $kibana_defaultappid = $kibana::params::kibana_defaultappid,
  $kibana_pidfile      = $kibana::params::kibana_pidfile,
  $kibana_logfile      = $kibana::params::kibana_logfile,
  $elastic_verify      = $kibana::params::elastic_verify,
  $elastic_ca          = $kibana::params::elastic_ca,
  $server_key          = $kibana::params::server_key,
  $server_cert         = $kibana::params::server_cert,
  $tmpfile             = $kibana::params::tmpfile
  ) {

  include kibana::params

    notify { "## --->>> Installing and configuring ${package_name}": }

    anchor { 'kibana::begin': } ->
    class { '::kibana::config': } ~>
    class { '::kibana::install': } ->
    anchor { 'kibana::end': }

}


# vim: set ts=2 sw=2 et :
