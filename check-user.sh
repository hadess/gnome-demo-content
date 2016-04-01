#!/bin/sh -e

NEEDS_CREATION=""
id gnome > /dev/null 2>&1 || NEEDS_CREATION=1

if test x$NEEDS_CREATION = x1 ; then
	echo "GNOME user created, re-run this script as the user"
	useradd gnome
fi

echo "Resetting GNOME password to \"gnome\""
echo gnome | passwd --stdin gnome > /dev/null

echo "Setting up login icon"
cat > /var/lib/AccountsService/users/gnome  << EOF
[User]
XSession=gnome
Icon=/var/lib/AccountsService/icons/gnome
SystemAccount=false
EOF

cp -f user-icons/gnome /var/lib/AccountsService/icons/gnome
