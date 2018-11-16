# puppet-ari

# Description

Puppet roles and profiles to ease the configuration, setup and installation of software:

- [Puppetlabs/mysql version 3.11.0](https://forge.puppet.com/puppetlabs/mysql/3.11.0/readme), to install mysql server
- [Puppet/nginx version 0.6.0](https://forge.puppet.com/puppet/nginx/0.6.0/readme), as a reverse proxy
- [Biemond/wildfly version 1.2.8](https://forge.puppet.com/biemond/wildfly/1.2.8/readme), which provides an installation for KeyCloak
- [Puppetlabs/java version 1.6.0](https://forge.puppet.com/puppetlabs/java/1.6.0/readme), to install javav
- [Puppetlabs/tomcat version 1.7.0](https://forge.puppet.com/puppetlabs/tomcat/1.7.0/readme), to deploy the services
- [Puppetlabs/ntp version 4.2.0](https://forge.puppet.com/puppetlabs/ntp/4.2.0/readme), to install ntp for time sync

Those versions have been selected to work with puppet 3.8.5.

# Technologies

Puppet, git

# How to deploy

You can use r10k or librarian puppet to download the module with the roles and profiles. An example is available [here]().


## Build
```
mod "puppet-ari",
	git: "https://github.com/AriHealth/puppet-ari.git"
```
## Test
```
```

# How to contribute

Features and bug fixes are more than welcome. They must be linked to an issue, so the first step before contributing is the creation of a [GitHub issue](https://github.com/carloscaverobarca/puppet-ari/issues).

# External resources

- [Craig Dunn's blog - Designing Pupeet - Roles and profiles](https://www.craigdunn.org/2012/05/239/)
- [Roles and profiles - a complete example](https://puppet.com/docs/pe/2017.1/r_n_p_full_example.html)
- [Roles and profiles](https://github.com/hunner/roles_and_profiles)
- [Module fundamentals](https://puppet.com/docs/puppet/4.9/modules_fundamentals.html)

# License

Apache 2.0


