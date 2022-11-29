#!/usr/bin/env bash
if [ ! -f /var/local/puppet_init.log ]; then
  wget https://apt.puppet.com/puppet-release-bullseye.deb
  dpkg -i puppet-release-bullseye.deb
  apt-get -y update
  apt-get -y install puppet-agent
  apt-get -y install dnsutils htop lsof
  # actually logstash puppet module fails with j11 and need to be rerun
  # well finding java 9 would probably have helped - or fixing the module
  apt-get -y install openjdk-11-jre
fi;
# r10k would be neater but...
/opt/puppetlabs/bin/puppet module install elastic-logstash --version 6.1.5 --ignore-dependencies
/opt/puppetlabs/bin/puppet module install puppet-nginx --version 4.0.0
/opt/puppetlabs/bin/puppet module install puppet-elastic_stack --version 8.0.2
%{ if is_elastic_node }
/opt/puppetlabs/bin/puppet module install puppet-elasticsearch --version 8.0.2
/opt/puppetlabs/bin/puppet module install puppet-kibana --version 7.0.1
%{ endif }
cd /var/local
/opt/puppetlabs/puppet/bin/puppet apply --verbose config.pp > puppet_init.log 2>&1
if [ $? -gt 2 ]; then
  # puppet run failed retrying
  /opt/puppetlabs/puppet/bin/puppet apply --verbose config.pp >> puppet_init.log 2>&1
fi
