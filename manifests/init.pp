# == Class: kibana4
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
#   service_ensure               = start the Kibana4 serve
#   service_enable               = enable on reboot
#   service_name                 = the service name
#   elastic_vip                  = the vip IP of the elastic cluster
#   elastic_url                  = the url of the elastic cluster
#   elastic_cert                 = full path of the elastic certificate
#   elastic_key                  = full path of the elastic key
#   elastic_password             = elastic search password
#   elastic_username             = elastic search username
#   kibana_index                 = default kibana index
#   kibana_defaultAppId          = default kibaba app
#   elastic_verify               = boolean ssl verify setting
#   elastic_ca                   = to set if openssl verify is not automatic
#   server_key                   = full path of the kibana key
#   server_cert                  = full path of the kibana certificate
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
  $version                       = 'latest',
  $repo_version                  = '4.5',
  $service_ensure                = 'true',
  $service_enable                = 'true',
  $service_name                  = 'kibana',
  $elastic_vip                   = hiera('elk_stack_elastic_address'),
  $elastic_url                   = "http://els_cluster:9200",
  $elastic_cert                  = '/etc/nginx/ssl/elastic.crt',
  $elastic_key                   = '/etc/nginx/ssl/elastic.key',
  $elastic_password              = 'welcome1',
  $elastic_username              = 'webops',
  $kibana_index                  = '.kibana',
  $kibana_defaultAppId           = 'discover',
  $elastic_verify                = 'true',
  $elastic_ca                    = undef,
  $server_key                    = '/etc/nginx/ssl/kibana.key',
  $server_cert                   = '/etc/nginx/ssl/kibana.crt'
  ){

  class { 'kibana4':
    version                      => $version,
    package_repo_version         => $repo_version,
    config                       => {
      'server.port'                  => 5601,
      'server.host'                  => '0.0.0.0',
      'elasticsearch.url'            => $elastic_url,
      'elasticsearch.preserveHost'   => true,
      'elasticsearch.ssl.cert'       => $elastic_cert,
      'elasticsearch.ssl.key'        => $elastic_key,
      'elasticsearch.password'       => $elastic_password,
      'elasticsearch.username'       => $elastic_username,
      'elasticsearch.pingTimeout'    => 1500,
      'elasticsearch.startupTimeout' => 5000,
      'kibana.index'                 => $kibana_index,
      'kibana.defaultAppId'          => $kibana_defaultAppId,
      'logging.silent'               => false,
      'logging.quiet'                => false,
      'logging.verbose'              => false,
      'logging.events'               => "{ log: ['info', 'warning', 'error', 'fatal'], response: '*', error: '*' }",
      'elasticsearch.requestTimeout' => 500000,
      'elasticsearch.shardTimeout'   => 0,
      'elasticsearch.ssl.verify'     => $elastic_verify,
      'server.ssl.key'               => $server_key,
      'server.ssl.cert'              => $server_cert,
      'pid.file'                     => '/var/run/kibana.pid',
      'logging.dest'                 => '/var/log/kibana/kibana.log'
      },
    plugins                          => {
      'elasticsearch/marvel'         => {
        plugin_dest_dir              => 'marvel',
        ensure                       => present,
        },
      'elastic/sense'                => {
         plugin_dest_dir             => 'sense',
         ensure                      => present,
        },
      }
    }

    host { "ops-es-cluster":
      ensure            => 'present',
      target            => '/etc/hosts',
      ip                => $elastic_vip,
      host_aliases      => 'els_cluster'
    }

    file { "/etc/nginx/ssl":
      ensure            => 'directory',
      owner             => 'root',
      group             => 'root',
      mode              => '0755',
    }

    file { $server_key:
      ensure            => file,
      owner             => 'root',
      group             => 'root',
      mode              => '0644',
      content           => hiera('elk_stack_kibana_key')
    }

    file { $server_cert:
      ensure            => file,
      owner             => 'root',
      group             => 'root',
      mode              => '0644',
      content           => hiera('elk_stack_kibana_cert')
    }

    file { $elastic_key:
      ensure            => file,
      owner             => 'root',
      group             => 'root',
      mode              => '0644',
      content           => hiera('elk_stack_elastic_key')
    }

    file { $elastic_cert:
      ensure            => file,
      owner             => 'root',
      group             => 'root',
      mode              => '0644',
      content           => hiera('elk_stack_elastic_cert')
    }

    file { "/etc/nginx/conf.d/kibana.conf":
      ensure            => file,
      owner             => 'root',
      group             => 'root',
      mode              => '0644',
      content           => template('kibana/nginx_kibana_conf.erb')
    }

  }



# vim: set ts=2 sw=2 et :
