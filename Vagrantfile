# (C) 2014-2016 Gunnar Andersson
# License: MPLv2

# -*- mode: ruby -*-
# vim: set ft=ruby sw=4 ts=4 tw=0 et:

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Apparently this needs to be specified if Vagrant has alternative options
# (trying this with other Vagrant providers is currently untested and users
#  must try that on their own._)
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

   # Set defaults, or as defined by environment variables

   hostname = ENV['HOSTNAME']
   hostname = 'ubuntu-system' if hostname == nil

   box = ENV['BOX']
   box = "trusty64" if box == nil

   box_url = ENV['BOX_URL']
   box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box" if box_url == nil

   source_dir = ENV['SOURCE_DIR']
   source_dir = 'install/' if source_dir == nil
   source_dir = "/vagrant/#{source_dir}"

   config.vm.box = box
   config.vm.hostname = hostname
   config.vm.box_url = box_url

   # To run eclipse we need more than default RAM 512MB And we might as well
   # set a useful name also, which I prefer to have equal to the hostname that
   # was defined above, but to make it unique a timestamp is added also.
   # Increase video RAM as well, it doesn't cost much and we will run
   # graphical desktops after all.
   vmname = config.vm.hostname + "-" + Time.now.strftime("%Y%m%d%H%M")
   config.vm.provider :virtualbox do |vb|
      vb.gui = false

      vb.customize [ "modifyvm", :id, "--name", vmname ]
      vb.customize [ "modifyvm", :id, "--memory", "1536" ]
      vb.customize [ "modifyvm", :id, "--vram", "128" ]
   end

   config.vm.provision :shell, inline:
      'echo "***************************************************************"
       echo "Starting provisioning. "
       echo "***************************************************************"'

   config.vm.provision :shell, inline:
      "
      echo Running: rsync -av --delete #{source_dir}/ /home/vagrant/
      rsync -av --delete #{source_dir}/ /home/vagrant/
      "

   # Created/copied files, are owned by root after provisioning - fix that
   config.vm.provision :shell, inline:
      " sudo chown -R vagrant:vagrant /home/vagrant

      # Remove other users than vagrant -- makes things less confusing
      sudo deluser ubuntu   # Might fail but that is ok
      true                  # Make sure Vagrant does not stop on error
      "

   # Export the VM name to make it known (build artifact)
   ENV['VMNAME'] = vmname

   # Run final installation script, if it exists
   config.vm.provision :shell, inline:
   " [ -f /vagrant/script.sh ] && /vagrant/script.sh 
     echo #{vmname} >VMNAME
   "
end
