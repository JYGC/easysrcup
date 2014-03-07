This script is just a collect of commands from the NetBSD Guide chapter 30 through 34 for updating NetBSD 6.0 and 6.1 from source. The purpose of this script is to avoid typing to many commands when updating (obvious). This script is useful only when generic compile options are need in building the system. But feel free to modify it for your own needs or email me some suggestions or code.

I must urge caution with this script as it hasn't been tested fully yet. Updating X11 isn't working yet.

Also I do not claim any copyright to this script as all of it's contents were written by NetBSD developers so don't come to me with any lawsuits or related crap.


@@@@@@@@@@@@@@@@@@@@@@@ USAGE OF SCRIPT @@@@@@@@@@@@@@@@@@@@@@@@@@

Put script in /usr directory.


To fetch or update the kernel and userland sources:

$ /usr/easysrcup.sh fetch src


To fetch or update the X11 sources

$ /usr/easysrcup.sh fetch x11


To fetch or update pkgsrc:

$ /usr/easysrcup.sh fetch pkgsrc


To build the kernel and userland:

$ /usr/easysrcup.sh build src


To build X11 (this is not working yet):

$ /usr/easysrcup.sh build x11


To install a freshly built kernel:

$ /usr/easysrcup.sh install kernel


To install a freshly built userland:

$ /usr/easysrcup.sh install userland


To install a freshly built x11 set (this is not working yet):

$ /usr/easysrcup.sh install x11
