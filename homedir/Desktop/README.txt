TIPS and instructions
=====================

Starting page for GDP documentation:
https://at.projects.genivi.org/wiki/pages/viewpage.action?pageId=11567210

(this URL might change in the future - if that is the case, just find 
 the GENIVI Wiki front page and click to the GENIVI Development Platform project)


Renesas Porter-board:
---------------------

For deploying binaries from QtCreator on Porter, it has been reported that this is needed:

1. Select Projects Mode by clicking the icon named "Projects" on the left,
2. Select the Run tab of the GDP-SDK for Porter Kit.
3. Under Run Environment add the following environment variable:

Variable: LD_PRELOAD,  Value: /usr/lib/libEGL.so


Virtual machine misconfigured?
------------------------------
Want more memory, more CPU, a folder shared with the host...?

Shut down, and reconfigure the VM.

Report if you think something should be changed in the default setup!


Missing something?
------------------
Connect to Internet, open a terminal, and:

$ sudo apt-get install <package>

If you think it's something useful for the default setup - let someone know!


