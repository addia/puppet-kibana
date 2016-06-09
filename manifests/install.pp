# == Class: kibana::install
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
class kibana::install (
  $version                       = $kibana4::params::version,
  $repo_version                  = $kibana4::params::repo_version,
  $elk_ca_root                   = $kibana4::params::elk_ca_root,
  $elastic_url                   = $kibana4::params::elastic_url,
  $elastic_cert                  = $kibana4::params::elastic_cert,
  $elastic_key                   = $kibana4::params::elastic_key,
  $elastic_password              = $kibana4::params::elastic_password,
  $elastic_username              = $kibana4::params::elastic_username,
  $kibana_index                  = $kibana4::params::kibana_index,
  $kibana_defaultAppId           = $kibana4::params::kibana_defaultAppId,
  $kibana_pidfile                = $kibana4::params::kibana_pidfile,
  $kibana_logfile                = $kibana4::params::kibana_logfile,
  $kibana_port                   = $kibana4::params::kibana_port,
  $elastic_verify                = $kibana4::params::elastic_verify,
  $elastic_ca                    = $kibana4::params::elastic_ca,
  $server_key                    = $kibana4::params::server_key,
  $server_cert                   = $kibana4::params::server_cert
) inherits kibana::params {

  notify { "## --->>> Installing package: ${package_name}": }

  class { 'kibana4':
    version                      => $version,
    package_repo_version         => $repo_version,
    config                       => {
      'server.port'                  => $kibana_port,
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
      'pid.file'                     => $kibana_pidfile,
      'logging.dest'                 => $kibana_logfile
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

  class { 'nginx' :
    confd_purge                      => true,
    vhost_purge                      => true,
    mail                             => false,
    }

  selinux::port { 'allow_kibana_port':
    context                          => 'http_port_t',
    port                             => $kibana_port,
    protocol                         => 'tcp',
    }

  oa_cert::ca { 'adding_elk_cert':
    ca_text                          => $elk_ca_root,
    ensure                           => 'trusted',
    source                           => hiera('elk_ca_cert'),
    }

  }


# vim: set ts=2 sw=2 et :
