# === Copyright
#
# Copyright (C) 2018  Atos Spain SA. All rights reserved.
#
# === License
#
# profile::keycloak is free software: you can redistribute it and/or modify it under the 
# terms of the Apache License, Version 2.0 (the License);
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# The software is provided "AS IS", without any warranty of any kind, express or implied,
# including but not limited to the warranties of merchantability, fitness for a particular
# purpose and noninfringement, in no event shall the authors or copyright holders be 
# liable for any claim, damages or other liability, whether in action of contract, tort or
# otherwise, arising from, out of or in connection with the software or the use or other
# dealings in the software.
# 
# See README file for the full disclaimer information and LICENSE file for full license 
# information in the project root.
# 
# == Class: profile::keycloak
#
# Install wildfly keycloak using the puppet module biemond/wildfly version 1.2.8.
#
# === Parameters
#
# [*source*]
#   Source where to download the keycloak tar file.
#   Example: 'https://downloads.jboss.org/keycloak/3.3.0.Final/keycloak-3.3.0.Final.tar.gz'
#
# [*db*]
#   Database for the mysql creation.
#   Example: 'keycloak'
#
# [*user*]
#   Mysql database user.
#   Example: 'keycloak'
#
# [*password*]
#   Mysql database password.
#   Example: 'password'
#
# [*port*]
#   Port to deploy KeyCloak.
#   Example: '9090'
#
# [*management_user*]
#   Admin user for the KeyCloak console.
#   Example: admin
#
# [*management_password*]
#   Admin password for the KeyCloak console.
#   Example: admin_password
#
# [*java8_home*]
#   java_home configuration for the wildfly service to work.
#   Example: '/usr/lib/jvm/java-8-openjdk-amd64'
#
# === Authors
#
# Author	Carlos Cavero
#			Atos Research and Innovation, Atos SPAIN SA
#			e-mail carlos.cavero@atos.net 
# 

class profile::keycloak(
  $source,
  $db,
  $user,
  $password,
  $management_user,
  $management_password,
  $port,
  $java8_home
) {

  class { 'wildfly':
    version        => '10.1.0',
    distribution   => 'wildfly',
    install_source => $source,
    dirname           => '/opt/wildfly',
    mode              => 'standalone',
    config            => 'standalone.xml',
	java_home         => $java8_home,
    properties       => {
      'jboss.http.port' => $port,
    },
    require  => Class['java']
  } 
  
  mysql::db { $db:
    ensure => present,
    user     => $user,
    password => $password,
    host     => 'localhost',
	grant    => ['ALL'],
  } ->
  # Configure the mySQL data source   
  wildfly::config::module { 'com.mysql':
    source       => 'http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.42/mysql-connector-java-5.1.42.jar',
    dependencies => ['javax.api', 'javax.transaction.api'],
	require      => Class['wildfly']
  } ->  
  wildfly::datasources::driver { 'Driver mysql':
    driver_name         => 'mysql',
    driver_module_name  => 'com.mysql',
    driver_class_name   => 'com.mysql.jdbc.Driver'
  } ->
  wildfly::datasources::datasource { 'KeycloakDS':
    config         => {
      'driver-name'    => 'mysql',
      'connection-url' => "jdbc:mysql://localhost:3306/${db}?useSSL=false&amp;characterEncoding=UTF-8",
      'jndi-name'      => 'java:/jboss/datasources/KeycloakDS',
      'user-name'      => $user,
      'password'       => $password
    }
  } ->
  wildfly::resource { '/subsystem=undertow/server=default-server/http-listener=default':
    content => {
     proxy-address-forwarding => true
    }
  } ->
  wildfly::cli { 'Reload if necessary':
    command => ':reload',
    onlyif  => '(result == reload-required) of :read-attribute(name=server-state)'
  }
  
  wildfly::config::mgmt_user { $management_user:
    password => $management_password,
    require  => Class['wildfly']
  } ->  
  wildfly::config::user_groups { $management_user:
     groups => 'admin'
  } ->
  wildfly::reload { 'Reload if necessary':
    retries => 2,
    wait    => 15,
  }
}
