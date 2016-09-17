SDE (Software Development Environment)
======================================

This repo contains scripted instructions for the *final assembly* 
of GDP SDE as a virtual machine image for VirtualBox.

But since we use [Go.CD](http://go.cd) to automate the build, many aspects of the instructions for creation of the content are inside of Go and not here.

We build the final environment using multiple stages in a pipeline - for example, most of the tools are compiled by earlier stages or pipelines that feed into the final assembly pipeline.

The purpose of this repo is therefore only to collect up what little steps remain and to automate the creation of the  virtual machine image.

(An important reason to build the individual parts separately and not tied to this repository is that they
may be usable in other configurations, or downloaded and installed locally on a host independent of any virtual machine)

Purpose and content of this repo:

* Except for major tool installtions, the content for the home directory (see below), such as
** various .dotfiles and other such configuration
** smaller helper scripts and binaries that were not part of earlier pipeline stages
** other needed data, such as desktop wallpaper
* Finally, a single shell script to execute apt-get install of the 

Mechanics of operation:
-----------------------

* In addition to the above, the repo has a simple [Vagrantfile](http://vagrantup.com)
that imports a base distro and simply copies the content of homedir/ into the main home directory of the virtual machine.  

* The first step is thus that all the content of homedir/ is rsync:ed over as-is. 

NOTE: Extending or configuring the SDE is thereby often simply a matter of adding and editing files under homedir/ exactly in the relative location where they should end up.  *Send pull requests!*

(A possible future alternative is to just keep all the content in another git repo and just git clone that to the home dir.)

- In the final step script.sh is run inside the VM for steps that need to execute such as apt-get installs and any other scripted steps.

