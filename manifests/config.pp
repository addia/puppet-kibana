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
  $package_name        = $kibana::params::package_name,
  $service_ensure      = $kibana::params::service_ensure,
  $service_enable      = $kibana::params::service_enable,
  $service_name        = $kibana::params::service_name,
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

  notify { "## --->>> Configuring package: ${package_name}": }


  user { 'kibana':
    ensure     => 'present',
    shell      => '/bin/bash',
    home       => '/opt/kibana',
    password   => '!!',
    managehome => true,
  }

  host { $elastic_cluster:
    ensure       => 'present',
    target       => '/etc/hosts',
    ip           => $elastic_vip_ip,
    host_aliases => $elastic_instance,
    }

  file { '/run/kibana':
    ensure => 'directory',
    owner  => 'kibana',
    group  => 'kibana',
    mode   => '0755',
    }

  file { '/var/log/kibana':
    ensure => 'directory',
    owner  => 'kibana',
    group  => 'kibana',
    mode   => '0755',
    }

  file { $tmpfile:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/kibana/tmpfiles_kibana.conf',
    }

  file { '/var/log/kibana/kibana.log':
    ensure => present,
    owner  => 'kibana',
    group  => 'kibana',
    mode   => '0644'
    }

  file { '/etc/nginx/ssl':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    }

  file { $server_key:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => hiera('elk_stack_kibana_key')
    }

  file { $server_cert:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => hiera('elk_stack_kibana_cert')
    }

  file { $elastic_key:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => hiera('elk_stack_elastic_key')
    }

  file { $elastic_cert:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => hiera('elk_stack_elastic_cert')
    }

  }


# vim: set ts=2 sw=2 et :
