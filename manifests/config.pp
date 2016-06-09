# == Class: kibana::config
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
class kibana::config (
  $service_ensure                = $kibana4::params::service_ensure,
  $service_enable                = $kibana4::params::service_enable,
  $service_name                  = $kibana4::params::service_name,
  $elastic_vip                   = $kibana4::params::elastic_vip,
  $elastic_url                   = $kibana4::params::elastic_url,
  $elastic_cert                  = $kibana4::params::elastic_cert,
  $elastic_key                   = $kibana4::params::elastic_key,
  $elastic_password              = $kibana4::params::elastic_password,
  $elastic_username              = $kibana4::params::elastic_username,
  $kibana_server                 = $kibana4::params::kibana_server,
  $kibana_server_ip              = $kibana4::params::kibana_server_ip,
  $kibana_index                  = $kibana4::params::kibana_index,
  $kibana_defaultAppId           = $kibana4::params::kibana_defaultAppId,
  $kibana_pidfile                = $kibana4::params::kibana_pidfile,
  $kibana_logfile                = $kibana4::params::kibana_logfile,
  $elastic_verify                = $kibana4::params::elastic_verify,
  $elastic_ca                    = $kibana4::params::elastic_ca,
  $server_key                    = $kibana4::params::server_key,
  $server_cert                   = $kibana4::params::server_cert,
  $tmpfile                       = $kibana4::params::tmpfile
) inherits kibana::params {

  notify { "## --->>> Configuring package: ${package_name}": }


  host { "ops-es-cluster":
    ensure            => 'present',
    target            => '/etc/hosts',
    ip                => $elastic_vip,
    host_aliases      => 'els_cluster'
    }

  file { "/run/kibana":
    ensure            => 'directory',
    owner             => 'kibana',
    group             => 'kibana',
    mode              => '0755',
    }

  file { "/var/log/kibana":
    ensure            => 'directory',
    owner             => 'kibana',
    group             => 'kibana',
    mode              => '0755',
    }

  file { "$tmpfile":
    ensure            => file,
    owner             => 'root',
    group             => 'root',
    mode              => '0644',
    source            => "puppet:///modules/kibana4/tmpfiles_kibana.conf",
    }

  file { "/var/log/kibana/kibana.log":
    ensure            => present,
    owner             => 'kibana',
    group             => 'kibana',
    mode              => '0644'
    }

  file { "/etc/nginx/ssl":
    ensure            => 'directory',
    owner             => 'root',
    group             => 'root',
    mode              => '0755',
    }

  file { "$server_key":
    ensure            => file,
    owner             => 'root',
    group             => 'root',
    mode              => '0644',
    content           => hiera('elk_stack_kibana_key')
    }

  file { "$server_cert":
    ensure            => file,
    owner             => 'root',
    group             => 'root',
    mode              => '0644',
    content           => hiera('elk_stack_kibana_cert')
    }

  file { "$elastic_key":
    ensure            => file,
    owner             => 'root',
    group             => 'root',
    mode              => '0644',
    content           => hiera('elk_stack_elastic_key')
    }

  file { "$elastic_cert":
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
