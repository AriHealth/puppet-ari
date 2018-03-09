# Install tomcat8

class profile::tomcat8(
	$user,
	$password,
	$deployer_password) {

	# set variables
	$tomcat_password = $password
	$tomcat_user = $user
	$deployer_password = $deployer_password)
  
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
		content => template('tomcat-users.xml.erb')
	} ->
	service { "tomcat8":
		ensure => running,
	}
}