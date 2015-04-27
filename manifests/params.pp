# Standard parameters for the fstab class

class fstab::params {

case $::osfamily {
  
  'Debian': { 
  
     $nfs_client_package = ['nfs-common',] 
     $nfs_server_package = ['nfs-kernel-server',] 
     
  } # 'Debian'
  
  # Packages for RHEL6 are different than RHEL7
  'RedHat': { 
  
     $nfs_server_package = $::lsbmajdistrelease ?  {
       6 =>  ['nfs-utils', 'nfs-utils-lib'],
       7 =>  ['nfs-utils', 'libnfsidmap'],
     }    
 
     $nfs_client_package = $::lsbmajdistrelease ?  {
        6 =>  ['nfs-utils', 'nfs-utils-lib'],
        7 =>  ['nfs-utils', 'libnfsidmap'],
      }     
      
    } # 'RedHat'

} # case

$cifspackage = 'cifs-utils' # This is true for Debian and Redhat

}
