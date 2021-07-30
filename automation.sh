#!/bin/bash

bzr builddeb -- -us -uc > dependencies.txt # or dpkg-buildpackage -us -uc etc...
sed -i -n '/Unmet build dependencies: /p' dependencies.txt
sed -i 's/dpkg-checkbuilddeps: error: Unmet build dependencies: //g; s/(\([>=]*\) \([0-9.]*\))//g; s/|//g' dependencies.txt

if [ -s dependencies.txt ]
then
	apt install $(cat dependencies.txt)
	bzr builddeb -- -us -uc
else
	echo "PACKAGE BUILT!\nNO MISSING DEPENDENCIES..."
fi

# auto remove dependencies.txt by adding rm command...
