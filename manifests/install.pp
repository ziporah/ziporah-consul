class consul::install {

  package { 'device-mapper-libs':
    ensure => installed,
    }

  class { 'docker':
    version       => $consul::docker_version,
    tcp_bind      => $consul::docker_tcp_bind,
    socket_bind   => 'unix:///var/run/docker.sock',
    require       => Package['device-mapper-libs']
  } ->

  docker::image { $consul::docker_image : } ->

  docker::run { $consul::container_hostname:
    image     => $consul::docker_image,
    hostname  => $consul::container_hostname,
    command   => "-server --advertise ${consul::consul_advertise} -bootstrap-expect ${consul::consul_bootstrap_expect}",
    ports     => ['8301:8301', '8301:8301/udp', '8302:8302', '8302:8302/udp', '8400:8400', '8500:8500', '53:53/udp']
    }

}
