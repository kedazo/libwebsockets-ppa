#!/bin/bash
# David Kedves <kedazo@gmail.com>

if [ ! -d debian ]; then
    echo "Please execute this script inside the project directory."
    exit 1
fi

echo "WARNING: this script will remove all ../libwebsockets* files"
read

rm -fv ../libwebsockets*

for distro in xenial bionic eoan focal groovy hirsute; do
    debchange --team --distribution=$distro "Release for $distro."

    dpkg-buildpackage -rfakeroot -S
done

dput ppa:kedazo/libwebsockets ../libwebsockets*.changes

