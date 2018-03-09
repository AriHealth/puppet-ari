# Install tomcat8

class profile::tomcat8(
	$user,
	$password,
	$password_deployer) {

	# set variables
	$tomcat_password = $password
	$tomcat_user = $user
	$deployer_password = $password_deployer
  
	package { 'tomcat8':
		ensure => present,
		require => Class["java8"]
	} ->
	package { 'tomcat8-admin':
		ensure => present,
	} ->
	file { "tomcat-users.xml":
		owner => 'root',
		path => '/etc/tomcat8/tomcat-users.xml',
		content => template('ari/tomcat-users.xml.erb')
	} ->
	service { "tomcat8":
		ensure => running,
	}
}
