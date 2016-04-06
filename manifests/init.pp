# == Class: fstab
#
# This class installs the nfs-common package
# this will allow mounts to be made for nfs shares
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
# - Mike Wilson - mw@ceh.ac.uk
#
class fstab(
  $nfs_version  = installed,
  $cifs_version = installed,
  $manage_nfs   = true,
  $manage_cifs  = false,
  $mounts       = {},
  $exports      = {},
) inherits fstab::params {

  $nfspackage = $::fstab::params::nfs_client_package
  $cifspackage = $::fstab::params::cifspackage

  if $manage_nfs {
    package { $nfs_client_package:
      ensure => $nfs_version
    }
    # Ensure that nfs packages are installed before setting up a mount
    Package[$nfspackage] -> Fstab::Mount<||>
  }

  if $manage_cifs {
    package { $cifspackage:
      ensure => $cifs_version
    }
    # Ensure that nfs packages are installed before setting up a mount
    Package[$cifspackage] -> Fstab::Mount<||>
  }
  
  if !empty($mounts) {
    create_resources('fstab::mount', $mounts)
  }
  
  if !empty($exports) {
    create_resources('fstab::export', $exports)
  }
}
