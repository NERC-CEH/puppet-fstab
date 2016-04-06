# == Class: fstab::server
#
# This class installs the nfs-kernel-server package
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
# - Mike Wilson - mw@ceh.ac.uk
#
class fstab::server (
  $nfs_version = installed
) {
  
  $nfs_server_package = $::fstab::params::nfs_server_package

  package {$nfs_server_package :
    ensure => $nfs_version
  }

  concat { '/etc/exports' : }

  # Execute the following when /etc/exports changes
  exec { 'exportfs -ra' :
    path        => '/usr/sbin',
    refreshonly => true,
    subscribe   => File['/etc/exports'],
    require     => Package[$nfs_server_package],
  }
}
