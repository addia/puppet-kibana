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
  $version                           = $kibana::params::version,
  $repo_version                      = $kibana::params::repo_version,
  $elastic_url                       = $kibana::params::elastic_url,
  $elastic_cert                      = $kibana::params::elastic_cert,
  $elastic_key                       = $kibana::params::elastic_key,
  $elastic_password                  = $kibana::params::elastic_password,
  $elastic_username                  = $kibana::params::elastic_username,
  $kibana_index                      = $kibana::params::kibana_index,
  $kibana_defaultAppId               = $kibana::params::kibana_defaultAppId,
  $kibana_pidfile                    = $kibana::params::kibana_pidfile,
  $kibana_logfile                    = $kibana::params::kibana_logfile,
  $kibana_port                       = $kibana::params::kibana_port,
  $elastic_verify                    = $kibana::params::elastic_verify,
  $elastic_ca                        = $kibana::params::elastic_ca,
  $server_key                        = $kibana::params::server_key,
  $server_cert                       = $kibana::params::server_cert
) inherits kibana::params {

  notify { "## --->>> Installing package: ${package_name}": }

  class { 'kibana4':
    version                          => $version,
    package_repo_version             => $repo_version,
    config                           => {
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
    confd_purge                      => false,
    vhost_purge                      => false,
    mail                             => false,
    }

  selinux::port { 'allow_kibana_port':
    context                          => 'http_port_t',
    port                             => $kibana_port,
    protocol                         => 'tcp',
    }

  }


# vim: set ts=2 sw=2 et :
