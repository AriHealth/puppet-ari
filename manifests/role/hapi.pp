class ari::role::hapi inherits role (
	$db,
	$user,
	$password
){
  include profile::java8
  include profile::tomcat8
  include profile::webserver
  include profile::db ->
  mysql::db { $db:
    ensure => present,
    user     => $user,
    password => $password,
    host     => 'localhost',
	grant    => ['ALL'],
  }
}
