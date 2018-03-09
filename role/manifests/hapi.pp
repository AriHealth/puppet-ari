class role::hapi inherits role {
  include profile::java8
  include profile::tomcat8
  include profile::nginx
  include profile::db
}
