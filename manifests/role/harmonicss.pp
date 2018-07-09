# === Copyright
#
# Copyright (C) 2018  Atos Spain SA. All rights reserved.
#
# === License
#
# ari::role::hapi is free software: you can redistribute it and/or modify it under the 
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
# == Class: ari::role::harmonicss
#
# Install Harmonicss software with MySQL, OAuth through KeyCloak, tomcat and nginx as reverse proxy.
#
# === Parameters
#
# [*db*]
#   Database for the mysql creation for Harmonics.
#   Example: harmonicss
#
# [*user*]
#   Mysql database user for Harmonicss.
#   Example: harmonicssuser
#
# [*password*]
#   Mysql database password for Harmonicss.
#   Example: harmonicsspassword
#
# === Authors
#
# Author	Carlos Cavero
#			Atos Research and Innovation, Atos SPAIN SA
#			e-mail carlos.cavero@atos.net 
# 

class ari::role::harmonicss () inherits role {
  include profile::java8
  include profile::tomcat8
  include profile::webserver
  include profile::db 
  include profile::hapi::mysql
  include profile::keycloak
}
