class profile::db(
	$root_password,
	$db,
	$user,
	$password
) {
# Install mySQL for production environment
  class { '::mysql::server':
    root_password => $root_password,
    remove_default_accounts => true,
  } ->
  mysql::db { $db:
    ensure => present,
    user     => $user,
    password => $password,
    host     => 'localhost',
	grant    => ['ALL'],
  }
}
