#!/bin/sh
#
# Script to automate kernel compilation
# Ryan P.C. McQuen | Everett, WA | ryan.q@linux.com
#
################################
### TO INSTALL/USE (MAKE SURE YOU ARE ROOT!):
### wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/kernelMe.sh -P /usr/src/
### cd /usr/src/
### sh kernelMe.sh
################################
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version, with the following exception:
# the text of the GPL license may be omitted.
#
# This program is distributed in the hope that it will be useful, but
# without any warranty; without even the implied warranty of
# merchantability or fitness for a particular purpose. Compiling,
# interpreting, executing or merely reading the text of the program
# may result in lapses of consciousness and/or very being, up to and
# including the end of all existence and the Universe as we know it.
# See the GNU General Public License for more details.
#
# You may have received a copy of the GNU General Public License
# along with this program (most likely, a file named COPYING). If
# not, see <http://www.gnu.org/licenses/>.
#
# Place this script in /usr/src, chmod +x it to make it executable
#
# Initial script by Robby Workman <http://rlworkman.net/>
# Slightly modified by Willy Sudiarto Raharjo <willysr@gmail.com>
#
##
## even further m0dz by Ryan P.C. McQuen  ;-)
## with lots of help from Thorn Inurcide
##
if [ ! $UID = 0 ]; then
  cat << EOF
This script must be run as root.
EOF
  exit 1
fi

if [ -z "$1" ]; then
  ## grab kernel homepage to get version numbers
  wget https://www.kernel.org/ -O ~/linux-kernel-home-page.html 

  ## mainline version
  cat ~/linux-kernel-home-page.html | grep "mainline" | grep -A1 ".xz" | head -1 | cut -d/ -f6 \
    | cut -d'"' -f1 | sed 's/patch//' | sed 's/-//' | sed 's/.xz//' \
      > ~/mainlineKernelVersion

  ## stable version
  cat ~/linux-kernel-home-page.html | grep "stable" | head -3 | tail -1 | cut -d'"' -f2 | cut -d/ -f13 | sed 's/v//' \
    > ~/stableKernelVersion

  ## longterm version
  cat ~/linux-kernel-home-page.html | grep "stable" | head -5 | tail -1 | cut -d'"' -f2 | cut -d/ -f13 | sed 's/v//' \
    > ~/longtermKernelVersion

  ## set VERSION
  export MAINLINEKERNEL=${MAINLINEKERNEL="$(tr -d '\n\r' < ~/mainlineKernelVersion)"} 
  export STABLEKERNEL=${STABLEKERNEL="$(tr -d '\n\r' < ~/stableKernelVersion)"} 
  export LONGTERMKERNEL=${LONGTERMKERNEL="$(tr -d '\n\r' < ~/longtermKernelVersion)"} 

  ## clean up
  rm -v ~/linux-kernel-home-page.html

  echo
  echo "-_-****************-_-"
  echo "*** KERNEL TIME!!! ***"
  echo "-_-****************-_-"
  echo
  read -p "Which kernel do you want (mainline, stable or longterm)?\
    [m/s/l]: " response
  case $response in
    [mM])
      export VERSION=$MAINLINEKERNEL;
      echo "Let's mainline this bizness!";
      ;;
    [sS])
      export VERSION=$STABLEKERNEL;
      echo "Oh so stable, and oh so sweet.";
      ;;
    [lL])
      export VERSION=$LONGTERMKERNEL;
      echo "In for the long haul.";
      ;;
    *)
      echo "You must choose."
      exit 1
      ;;
  esac
  echo
else
  VERSION=${1}
fi

echo
echo "You are building Linux $VERSION."
echo
read -p "Do you want 'menuconfig'?\
  [y/N]: " response
case $response in
  [yY][eE][sS]|[yY])
    export CONFIGOPTION=menuconfig;
    echo "You'll get the menu.";
    ;;
  *)
    export CONFIGOPTION=olddefconfig;
    echo "Just build it already!";
    ;;
esac
echo
echo

## grab the kernel
wget -N https://www.kernel.org/pub/linux/kernel/v3.x/linux-$VERSION.tar.xz

## check if wget failed
if [ $? -ne 0 ]; then
  echo "Version number is bunk, try again."
  exit 1
fi


CWD='/usr/src'
cd $CWD

## un tar dat thing
tar xvf $CWD/linux-$VERSION.tar.xz -C /usr/src/

#
## i don't use this symlink, so i'll keep it
##rm -f /usr/src/linux
#

# Switch to the kernel source directory
cd $CWD/linux-$VERSION
#
make mrproper

## set this to the running config, override if needed
KERNELCONFIG=${KERNELCONFIG:-/proc/config.gz}

## get the config, do the 'or cat' in case someone feeds a non-gzipped config
zcat ${KERNELCONFIG} > /usr/src/linux-$VERSION/.config || cat ${KERNELCONFIG} > /usr/src/linux-$VERSION/.config

# Make the kernel image, Compile, and Install The Modules
make $CONFIGOPTION && make bzImage && make modules && make modules_install

# copy new files into /boot
cp $CWD/linux-$VERSION/.config /boot/config-$VERSION
cp $CWD/linux-$VERSION/System.map /boot/System.map-$VERSION
cp $CWD/linux-$VERSION/arch/x86/boot/bzImage /boot/vmlinuz-$VERSION

## i don't like removing a working kernel, 
## this script already adds the new one as a 
## separate lilo entry, and does so by version name
##
##cd /boot
##rm -f vmlinuz System.map config
##
##ln -s vmlinuz-$VERSION vmlinuz
##ln -s System.map-$VERSION System.map
##ln -s config-$VERSION config

## this is a m0d of my generic kernel script
/usr/share/mkinitrd/mkinitrd_command_generator.sh /boot/vmlinuz-$VERSION | sh

## check for lilo, otherwise running this stuff is a waste
if [ -e /etc/lilo.conf ]; then
  if [ -e ~/liloGenericEntry.sh ]; then
    rm -v ~/liloGenericEntry.sh
  fi
  
  echo "/usr/share/mkinitrd/mkinitrd_command_generator.sh -l /boot/vmlinuz-$VERSION" > ~/liloGenericEntry.sh
  
  ## check for duplicate entries
  if [ -z "`grep $VERSION /etc/lilo.conf`" ]; then
    sh ~/liloGenericEntry.sh >> /etc/lilo.conf
  fi
  
  lilo -v
  
  ## clean up
  rm -v ~/liloGenericEntry.sh
else
  echo "You aren't using LILO, update your bootloader."
fi

## more clean up
rm -v ~/mainlineKernelVersion
rm -v ~/stableKernelVersion
rm -v ~/longtermKernelVersion

echo
echo "If you have LILO your new kernel is ready (as a new entry), so you can happily reboot."
echo
echo "If you don't have LILO, you'll need to bring your bootloader up to speed!"
echo
echo "ENJOY!"

# Good luck!

