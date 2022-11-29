# TODO
include elastic_stack::repo

class { 'elasticsearch':
  config => {
    'path.data'          => '/var/lib/elasticsearch',
    'path.logs'          => '/var/log/elasticsearch',
    'transport.host'     => 'localhost',
    'transport.tcp.port' => '9300',
    'http.port'          => '9200',
    'network.host'       => '0.0.0.0',
  }
}

class { 'kibana':
  config => {
    'server.port' => '8080',
    'server.host' => '0.0.0.0',
  }
}

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
