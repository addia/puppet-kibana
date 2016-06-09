# == Class: kibana::params
# ===========================
#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
# ===========================
#
class kibana::params {

  $version                       = 'latest'
  $repo_version                  = '4.5'
  $service_ensure                = 'true'
  $service_enable                = 'true'
  $service_name                  = 'kibana'
  $elastic_vip                   = hiera('elk_stack_elastic_address')
  $elastic_vip_ip                = hiera('elk_stack_elastic_ip')
  $elastic_url                   = "http://els_cluster:9200"
  $elastic_cert                  = '/etc/nginx/ssl/elastic.crt'
  $elastic_key                   = '/etc/nginx/ssl/elastic.key'
  $elastic_password              = 'welcome1'
  $elastic_username              = 'webops'
  $elk_ca_root                   = 'elk_ca.cert'
  $kibana_server                 = hiera('elk_stack_kibana_address')
  $kibana_server_ip              = hiera('elk_stack_kibana_ip')
  $kibana_port                   = hiera('elk_stack_kibana_port')
  $kibana_index                  = '.kibana'
  $kibana_pidfile                = '/run/kibana/pid'
  $kibana_logfile                = '/var/log/kibana/kibana.log'
  $kibana_defaultAppId           = 'discover'
  $elastic_verify                = 'true'
  $elastic_ca                    = undef
  $server_key                    = '/etc/nginx/ssl/kibana.key'
  $server_cert                   = '/etc/nginx/ssl/kibana.crt'
  $tmpfile                       = '/usr/lib/tmpfiles.d/kibana.conf'
}

