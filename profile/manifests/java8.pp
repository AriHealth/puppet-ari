class profile::java8() {

	java::oracle { 'jdk8' :
		ensure  => 'present',
		version => '8',
		java_se => 'jdk',
	}
}