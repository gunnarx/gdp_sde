SDE-Work (Software Development Environment)

This repo is an extension/specific use of basic-vagrant.  It includes
various files that are necessary to install on a SDE virtual machine, and
the script has been modified to install specific things.


Old basic-vagrant description:

Simple Vagrant file that mostly copies all the content of a given source
directory into the home directory in the virtual machine. In other words,
the preparation of that content should be done before the VM creation.

For some things it is still needed to install prerequisites using the
system's package managers like apt/yum/dnf/zypper/etc. and that of course
is done from within the VM.  The Vagrantfile executes ./script.sh if it
exists.

