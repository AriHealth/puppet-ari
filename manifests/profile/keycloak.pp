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
#   Source where to download the keycloak tar file."
#   Example: https://downloads.jboss.org/keycloak/2.5.0.Final/keycloak-2.5.0.Final.tar.gz
#
# === Authors
#
# Author	Carlos Cavero
#			Atos Research and Innovation, Atos SPAIN SA
#			e-mail carlos.cavero@atos.net 
# 

class profile::keycloak(
  $source
  $db,
  $user,
  $password,
  $management_user,
  $management_password
) {
  class { 'wildfly':
    version        => '10.1.0',
    distribution   => 'wildfly',
    install_source => $source,
    jboss_opts       => '-Djboss.socket.binding.port-offset=100'
    mgmt_user        => { username  => $management_user, password  => $management_password },
  } ->
  mysql::db { $db:
    ensure => present,
    user     => $user,
    password => $password,
    host     => 'localhost',
	grant    => ['ALL'],
  } ->
  wildfly::datasources::datasource { 'KeycloakDS':
  config => {
    'driver-name'    => 'mysql',
    'password'       => $user,
    'user-name'      => $password,
    'jndi-name'      => 'java:jboss/datasources/KeycloakDS',
    'connection-url' => "jdbc:mysql://localhost/$db",
    'background-validation' => true,
    'background-validation-millis' => 60000,
    'check-valid-connection-sql' => 'SELECT 1',
    'flush-strategy' => 'IdleConnections',
  }
}
}
