class role::webserver inherits role {
  include profile::java8
  include profile::tomcat8
  include profile::webserver
}
