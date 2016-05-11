# Land Registry's Kibana Install

A puppet module to manage the install of Kibana presentation layer at the Land Registry

## Requirements

* Puppet  >=  3.4
* The [stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib) Puppet library.
* The [kibana](https://forge.puppet.com/lesaux/kibana4) Lesaux Kibana4 module.

## Usage

### Main class

```
class ( 'kibana' )

https://www.elastic.co/guide/en/kibana/current/setup.html
https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-centos-7
http://devopscube.com/how-to-setup-an-elasticsearch-cluster/


checking with:  http://<kibana server>:5601/


```
### Message Management

```

```

### License

Please see the [LICENSE](https://github.com/LandRegistry-Ops/puppet-kibana/blob/master/LICENSE.md) file.

