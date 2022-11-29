include nginx

class { 'logstash':
  jvm_options => [
    '-Dfile.encoding=UTF-8',
    '-Djava.awt.headless=true',
    '-XX:+DisableExplicitGC',
    '-XX:+HeapDumpOnOutOfMemoryError',
    '-XX:+UseCMSInitiatingOccupancyOnly',
    '-XX:CMSInitiatingOccupancyFraction=75',
    '# -XX:+UseConcMarkSweepGC',
    '# -XX:+UseParNewGC',
    '-Xms256m',
    '-Xmx1g',
  ]
}
~> logstash::configfile { 'ls_conf':
  content => template('/etc/logstash_example'),
}
~> exec { 'please_dont_judge_me':
  unless  => '/usr/bin/getent group adm | grep -q logstash',
  command => '/usr/sbin/usermod -a -G adm logstash',
}
