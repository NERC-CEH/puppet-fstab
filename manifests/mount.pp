# == Define: nfs::mount
#
# The following defined type allows a mount to be defined.
# It will also ensure that a directory is already present
# for the mount to be applied to.
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
#
define nfs::mount (
  $ensure,
  $device,
  $options,
  $fstype = 'nfs4'
) {

  file { $name :
    ensure => directory,
  }

  mount { $name :
    ensure  => $ensure,
    device  => $device,
    options => $options,
    fstype  => $fstype,
    require => File[$name],
  }
}