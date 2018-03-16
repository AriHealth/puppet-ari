# === Copyright
#
# Copyright (C) 2018  Atos Spain SA. All rights reserved.
#
# === License
#
# profile::tomcat8 is free software: you can redistribute it and/or modify it under the 
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
# == Class: profile::java8
#
# Install tomcat8 using the puppet module puppetlabs/tomcat version 2.0.0.
#
# === Parameters
#
# Those parameters will change because in production we will not install the tomcat8-admin package
#
# [*user*]
#   Admin user for tomcat.
#
# [*password*]
#   Admin password for tomcat.
#
# [*password_deployer*]
#   Deployer tomcat for the CI.
#
# === Authors
#
# Author	Carlos Cavero
#			Atos Research and Innovation, Atos SPAIN SA
#			e-mail carlos.cavero@atos.net 
# 

class profile::tomcat8(
	$user,
	$password,
	$password_deployer) {

  tomcat::install { '/var/lib/tomcat8':
    source_url => 'https://www.apache.org/dist/tomcat/tomcat-8/v8.0.50/bin/apache-tomcat-8.0.50.tar.gz'
  } ->
  tomcat::instance { 'tomcat8':
    catalina_home => '/var/lib/tomcat8',
    catalina_base => '/var/lib/tomcat8'
  } ->
  tomcat::instance { 'tomcat8-admin':
    catalina_home => '/var/lib/tomcat8',
    catalina_base => '/var/lib/tomcat8'
  }->
  tomcat::config::server::tomcat_users {
   $user:
      catalina_base => '/var/lib/tomcat8',
      element  => 'user',
      password => $password,
      roles => ['manager-gui','admin'];
   'deployer':
      catalina_base => '/var/lib/tomcat8',
      element => 'user',
      password => $password_deployer,
      roles => ['manager-script'];
  }
}
