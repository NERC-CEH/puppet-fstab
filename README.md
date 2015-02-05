# puppet-fstab

A lightweight puppet module for managing fstab mounts and server exports

## Module Description

This puppet module will allow the managment of nfs and cifs mounts and exports.
It does this by backing on to the puppet Mount type, it will also ensure that a
mount point in the filesystem already exists.

## Setup

### What Puppet-Fstab affects

* Optionally installs nfs and cifs client software
* Manages the mount points
* Manages /etc/exports

## Usage

Mount to an NFS share
  
    class { 'fstab' : }

    fstab::mount { '/mountPoint':
      ensure  => 'mounted',
      device  => '10.0.0.1:/nfs/mount/point',
      options => 'ro,hard,rsize=32768,wsize=32768,nfsvers=3',
      fstype  => 'nfs',
    }

Mount to a CIFS share using username and password

    class { 'fstab':
      manage_cifs => true, # manage the cifs packages
    }
    
    $credentials = '/home/user/mount.smb'

    fstab::mount { '/mountPoint':
      ensure           => 'mounted',
      device           => '//windows-server/sharedFolder',
      credentials_file => $credentials,
      username         => 'msusername',
      password         => 'mspassword',
      options          => "credentials=${$credentials},sec=ntlm,uid=owner,gid=group,iocharset=utf-8",
      fstype           => 'cifs',
    }

## Limitations

This module has been tested on Ubuntu 14.04 and Centos 6

## Contributors

- Mike Wilson - mw@ceh.ac.uk
- Christopher Johnson - cjohn@ceh.ac.uk
