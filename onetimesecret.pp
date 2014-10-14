user { 'ots':
  ensure => present,
  home   => '/var/lib/onetime'
}

# Dependencies
package { [ 'redis-server', 'ntp', 'build-essential', 'libyaml-dev', 'libevent-dev', 'unzip',
            'zlib1g', 'zlib1g-dev', 'openssl', 'libssl-dev', 'libxml2', 'wget' ]:
  ensure => installed
}

# Ruby requirements
package { [ 'ruby1.9.1', 'ruby1.9.1-dev', 'bundler' ]:
  ensure => installed
}

# Using foreman as process manager
package {'installforeman':
  name     => 'foreman',
  ensure   => 'installed',
  provider => 'gem'
}

exec {'download-latest-onetime':
  unless  => '/usr/bin/test -f /etc/onetime/config',
  command => '/usr/bin/wget -q -O /tmp/onetime.zip https://github.com/onetimesecret/onetimesecret/archive/master.zip',
  creates => '/tmp/onetime.zip',
  require => Package['wget'],
  notify  => Exec['unpack']
}

exec { 'unpack':
  command     => '/usr/bin/unzip /tmp/onetime.zip -d /var/lib/onetime/ && /bin/mv /var/lib/onetime/onetimesecret-master/* /var/lib/onetime/',
  require     => [File['/var/lib/onetime'], Package['unzip']],
  notify      => Exec['bundle'],
  user        => 'ots',
  refreshonly => true
}

exec { 'bundle':
  require     => Package['bundler'],
  cwd         => '/var/lib/onetime',
  command     => '/usr/bin/bundle install --deployment --frozen --without=dev --gemfile /var/lib/onetime/Gemfile',
  user        => 'ots',
  refreshonly => true
}

File {
  require => User['ots'],
  owner   => 'ots',
  mode    => 0600,
}

file {
  [ '/etc/onetime', '/var/log/onetime', '/var/run/onetime', '/var/lib/onetime']:
    ensure  => directory;
}
