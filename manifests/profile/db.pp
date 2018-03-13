class profile::db(
	$root_password) {
# Install mySQL for production environment
  class { '::mysql::server':
    root_password => $root_password,
    remove_default_accounts => true,
  } 
}
