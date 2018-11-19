# === Copyright
#
# Copyright (C) 2018  Atos Spain SA. All rights reserved.
#
# === License
#
# profile::nginx::letsencrypt is free software: you can redistribute it and/or modify it under the 
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
# == Class: profile::nginx::letsencrypt
#
# Install nginx using the puppet module puppet/nginx version 0.6.0.
#
# === Parameters
#
# [*nginx_vhosts*]
#   To use nginx as a reverse proxy and redirect to other urls.
#
# [*nginx_location*]
#   To include locations in nginx.
#
# [*letsencrypt_certs*]
#   To configure the letsencrypt certs for nginx.
#
# === Authors
#
# Author	Carlos Cavero
#			Atos Research and Innovation, Atos SPAIN SA
# 

class profile::nginx-letsencrypt (
  $nginx_vhosts,
  $nginx_location,
  $letsencrypt_certs
) {
  class { 'letsencrypt': }
  class { 'nginx': }
  
  exec { 'first-run LE to get certs': # This only runs once, per the 'creates' parameter
    command => "/usr/bin/letsencrypt --text --agree-tos certonly -a standalone -d phs.atosresearch.eu",
    creates => "/etc/letsencrypt/live/phs.atosresearch.eu/fullchain.pem",
  }

  if $letsencrypt_certs!=undef {
    create_resources('letsencrypt::certonly', $letsencrypt_certs)
  }
  if $nginx_vhosts!=undef {
    create_resources('nginx::resource::server', $nginx_vhosts)
  }
  if $nginx_location!=undef {
    create_resources('nginx::resource::location', $nginx_location)
  }
}
