# == Class: nfs
#
# This class installs the nfs-common package
# this will allow mounts to be made for nfs shares
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
# - Mike Wilson - mw@ceh.ac.uk
#
class nfs(
  $nfs_version = installed,
) {
  $nfspackage = $::osfamily ? {
    'Debian' => ['nfs-common',],
    'RedHat' => ['nfs-utils', 'nfs-utils-lib'],
  }

  package { $nfspackage:
    ensure => $nfs_version
  }

  # Ensure that nfs packages are installed before setting up a mount
  Package[$nfspackage] -> Mount<||>
}