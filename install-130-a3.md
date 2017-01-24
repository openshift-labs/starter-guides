#** Lab: Installing the OpenShift CLI **

###**Command Line Interface**

OpenShift ships with a feature rich web console as well as command line tools
to provide users with a nice interface to work with applications deployed to the
platform.  The OpenShift tools are a single executable written in the Go
programming language and is available for the following operating systems:

- Microsoft Windows
- Apple OS X
- Linux

####**Downloading the tools**
During this lab, we are going to download the client tool and add them to our
operating system $PATH environment variables so the executable is accessible
from any directory on the command line.

The first thing we want to do is download the correct executable for your
operating system as linked below:

- [Microsoft Windows](https://github.com/openshift/origin/releases/download/v1.3.0-alpha.3/openshift-origin-client-tools-v1.3.0-alpha.3-7998ae4-windows.zip)
- [Apple OS X](https://github.com/openshift/origin/releases/download/v1.3.0-alpha.3/openshift-origin-client-tools-v1.3.0-alpha.3-7998ae4-mac.zip)
- [Linux 64](https://github.com/openshift/origin/releases/download/v1.3.0-alpha.3/openshift-origin-client-tools-v1.3.0-alpha.3-7998ae4-linux-64bit.tar.gz)
- [Linux 32](https://github.com/openshift/origin/releases/download/v1.3.0-alpha.3/openshift-origin-client-tools-v1.3.0-alpha.3-7998ae4-linux-32bit.tar.gz)


Once the file has been downloaded, you will need to extract the contents as it
is a compressed archive.  I would suggest saving this file to the following
directories:

**Windows:**

````
	C:\OpenShift
````

**OS X:**

````
	~/OpenShift
````

**Linux:**

````
	~/OpenShift
````

####**Extracting the tools**
Once you have the tools downloaded, you will need to extract the contents:

**Windows:**
In order to extract a zip archive on windows, you will need a zip utility
installed on your system.  With newer versions of windows (greater than XP),
this is provided by the operating system.  Just right click on the downloaded
file using file explorer and select to extract the contents.

**OS X:**
Open up a terminal window and change to the directory where you downloaded the
file.  Once you are in the directory, enter in the following command:

````
	$ tar zxvf oc-macosx.tar.gz
````

**Linux:**
Open up a terminal window and change to the directory where you downloaded the
file.  Once you are in the directory, enter in the following command:

````
	$ tar zxvf oc-linux.tar.gz
````

####**Adding *oc* to your PATH**

**Windows:**
Because changing your PATH on windows varies by version of the operating system,
we will not list each operating system here.  However, the general workflow is
right click on your computer name inside of the file explorer.  Select Advanced
system settings. I guess changing your PATH is considered an advanced task? :)
Click on the advanced tab, and then finally click on Environment variables.
Once the new dialog opens, select the Path variable and add ";C:\OpenShift" at
the end.  For an easy way out, you could always just copy it to C:\Windows or a
directory you know is already on your path. For more detailed instructions:

[Windows XP](https://support.microsoft.com/en-us/kb/310519)

[Windows Vista](http://banagale.com/changing-your-system-path-in-windows-vista.htm)

[Windows 7](http://geekswithblogs.net/renso/archive/2009/10/21/how-to-set-the-windows-path-in-windows-7.aspx "Windows 7")

[Windows 8](http://www.itechtics.com/customize-windows-environment-variables/)

Windows 10 - Follow the directions above.

**OS X:**

````
	$ export PATH=$PATH:~/OpenShift
````

**Linux:**

````
	$ export PATH=$PATH:~/OpenShift
````

####**Verify**
At this point, we should have the oc tool available for use.  Let's test this
out by printing the version of the oc command:

````
	$ oc version
````

You should see the following (or something similar):

````
	oc v1.3.0-alpha.3
	kubernetes v1.3.0+507d3a7
````

If you get an error message, you have not updated your path correctly.  If you
need help, raise your hand and the instructor will assist.

**[End of Lab](/)**
