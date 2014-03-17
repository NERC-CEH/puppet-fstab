# == Class: nfs
#
# This class installs the nfs-common package
# this will allow mounts to be made for nfs shares
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
#
class nfs(
  $nfs_common_version = installed,
) {
  package { 'nfs-common':
    ensure => $nfs_common_version
  }

  # Ensure that nfs-common is installed before setting up a mount
  Package['nfs-common'] -> Mount<||>
}