class profile::webserver (
  $nginx_vhosts,
  $nginx_location,
  # $letsencrypt_certs
) {
  # class { 'letsencrypt': }
  class { 'nginx': }
  
  # exec { 'first-run LE to get certs': # This only runs once, per the 'creates' parameter
  #  command => "/usr/bin/letsencrypt --text --agree-tos certonly -a standalone -d phs.atosresearch.eu",
  #  creates => "/etc/letsencrypt/live/phs.atosresearch.eu/fullchain.pem",
  # }

#  create_resources('letsencrypt::certonly', $letsencrypt_certs)
  create_resources('nginx::resource::server', $nginx_vhosts)
#  create_resources('nginx::resource::location', $nginx_location)
}
