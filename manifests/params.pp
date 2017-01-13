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

  $version             = 'latest'
  $repo_version        = '4.5'
  $package_name        = 'kibana'
  $service_ensure      = true
  $elastic_cluster     = hiera('elk_stack_elastic_clustername')
  $elastic_instance    = hiera('elk_stack_elastic_instance')
  $elastic_vip         = hiera('elk_stack_elastic_address')
  $elastic_vip_ip      = hiera('elk_stack_elastic_ip')
  $elastic_url         = "http://${elastic_instance}:9200"
  $elastic_cert        = '/etc/nginx/ssl/elastic.crt'
  $elastic_key         = '/etc/nginx/ssl/elastic.key'
  $elastic_password    = 'welcome1'
  $elastic_username    = 'webops'
  $kibana_fqdn         = hiera('elk_stack_kibana_fqdn')
  $kibana_server       = hiera('elk_stack_kibana_address')
  $kibana_server_ip    = hiera('elk_stack_kibana_ip')
  $kibana_port         = hiera('elk_stack_kibana_port')
  $kibana_index        = '.kibana'
  $kibana_pidfile      = '/run/kibana/pid'
  $kibana_logfile      = '/var/log/kibana/kibana.log'
  $kibana_defaultappid = 'discover'
  $elastic_verify      = true
  $elastic_ca          = undef
  $server_key          = '/etc/nginx/ssl/kibana.key'
  $server_cert         = '/etc/nginx/ssl/kibana.crt'
  $tmpfile             = '/usr/lib/tmpfiles.d/kibana.conf'
}

