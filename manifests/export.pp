# == Define: fstab::export
#
# The following defined type allows an fstab export to be defined.
# Multiple declarations of this defined type manage the 
# /etc/exports file
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
#
define fstab::export (
  $clients,
  $path = $name
) {

  concat::fragment { "/etc/exports ${name}":
    target  => '/etc/exports',
    content => "${path} ${clients}"
  }
}