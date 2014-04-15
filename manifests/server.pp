# == Class: nfs::server
#
# This class installs the nfs-kernel-server package
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
# - Mike Wilson - mw@ceh.ac.uk
#
class nfs::server (
  $nfs_version = installed
) {
  $nfspackage = $::osfamily ? {
    'Debian' => ['nfs-kernel-server',],
    'RedHat' => ['nfs-utils', 'nfs-utils-lib',],
  }

  package {$nfspackage :
    ensure => $nfs_version
  }

  concat { '/etc/exports' : }

  # Execute the following when /etc/exports changes
  exec { 'exportfs -ra' :
    path        => '/usr/sbin',
    refreshonly => true,
    subscribe   => File['/etc/exports'],
    require     => Package[$nfspackage],
  }
}