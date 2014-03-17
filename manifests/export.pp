# == Define: nfs::export
#
# The following defined type allows an nfs export to be defined.
# Multiple declarations of this defined type manage the 
# /etc/exports file
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
#
define nfs::export (
  $clients,
  $path = $name
) {

  concat::fragment { "/etc/exports ${name}":
    target  => '/etc/exports',
    content => "${path} ${clients}"
  }
}