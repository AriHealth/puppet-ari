class profile::java8() {

# Include apt package in the OS
include apt

Class['apt::update'] -> Package<| |>

  # java  repository
  apt::ppa {'ppa:webupd8team/java': }

  exec { 'accept-java-license':
    command => '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections;/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true | sudo /usr/bin/debconf-set-selections;',
    before => Package['oracle-java8-installer']
  } 
  
  package { "oracle-java8-installer":
    ensure => installed,
    require => Apt::Ppa['ppa:webupd8team/java'],
  }

}
