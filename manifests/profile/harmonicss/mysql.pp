# === Copyright
#
# Copyright (C) 2018  Atos Spain SA. All rights reserved.
#
# === License
#
# profile::db::harmonicss::mysql is free software: you can redistribute it and/or modify it under the 
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
# == Class: db::mysql
#
# Create the database, user and password for mysql and grant all access.
#
# === Parameters
#

# [*db*]
#   Database for the mysql creation.
#   Example: 'harmonicss'
#
# [*user*]
#   Mysql database user.
#   Example: 'harmonicssUser'
#
# [*password*]
#   Mysql database password.
#   Example: 'harmonicssPassword'
#
# === Authors
#
# Author	Carlos Cavero
#			Atos Research and Innovation, Atos SPAIN SA
#			e-mail carlos.cavero@atos.net 
# 

class profile::harmonicss::mysql(
  $db,
  $user,
  $password,
) {

  mysql::db { $db:
    ensure => present,
    user     => $user,
    password => $password,
    host     => 'localhost',
	grant    => ['ALL'],
  } 
}
