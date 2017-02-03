# == Class: fstab::params
#
# Standard parameters for the fstab class
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
# - Brian Schonecker - @bschonec
#
class fstab::params {

  case $::osfamily {
    'Debian': { 
      $nfs_client_package = ['nfs-common',] 
      $nfs_server_package = ['nfs-kernel-server',] 
    }
    'RedHat': { # Packages for RHEL6 are different than RHEL7
      $nfs_server_package = $::lsbmajdistrelease ?  {
        '6' =>  ['nfs-utils', 'nfs-utils-lib'],
        '7' =>  ['nfs-utils', 'libnfsidmap'],
      }   
      $nfs_client_package = $::lsbmajdistrelease ?  {
        '6' =>  ['nfs-utils', 'nfs-utils-lib'],
        '7' =>  ['nfs-utils', 'libnfsidmap'],
      }
    }
  }

  $cifspackage = 'cifs-utils' # This is true for Debian and Redhat
}
