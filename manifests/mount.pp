# == Define: fstab::mount
#
# The following defined type allows a mount to be defined. It will also ensure
# that a directory is already present for the mount to be applied to.
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
# - Mike Wilson - mw@ceh.ac.uk
#
define fstab::mount (
  $ensure,
  $device,
  $options,
  $manage_dir       = true,
  $fstype           = 'nfs4',
  $credentials_file = undef,
  $username         = undef,
  $password         = undef
) {

  validate_bool($manage_dir)

  if $manage_dir {
    file { $name :
      ensure => directory,
    }
  }

  # Some CIFS shares require a username and password combination
  # If provided we can create the credentials file on disk. This will need to
  # be supplied to the options when creating this mount.
  if $credentials_file {
    file { $credentials_file:
      mode    => 400,
      backup  => false,
      content => template('fstab/credentials.erb'),
      before  => Mount[$name],
    }
  }

  mount { $name :
    ensure  => $ensure,
    device  => $device,
    options => $options,
    fstype  => $fstype,
    require => File[$name],
  }
}
