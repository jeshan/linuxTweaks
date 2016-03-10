#!/bin/bash
## run as a normal user:
## wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/ubuntu/.ubuntu1404Setup.sh -P ~/; bash ~/.ubuntu1404Setup.sh

sudo apt-get update && sudo apt-get dist-upgrade -y

if [ -z "$(cat ~/.bash_aliases | grep 'alias apt')" ]; then
  echo "## my aliases" >> ~/.bash_aliases
  echo "alias aptu='sudo apt-get update && sudo apt-get dist-upgrade -y'" >> ~/.bash_aliases
  echo "alias aptc='sudo apt-get autoclean && sudo apt-get clean && sudo apt-get autoremove -y'" >> ~/.bash_aliases
  echo "alias apti='sudo apt-get install -y '" >> ~/.bash_aliases
fi

ESSENTIALPKGS="curl wget git vim vim-gnome build-essential zlib1g-dev libsndfile1-dev libsdl1.2-dev"

sudo apt-get install -y $ESSENTIALPKGS

## properly add google chrome repo, and install the beta
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
## check for this so we don't keep adding the same line on re-runs
if [ -z "$(find /etc/apt/sources.list.d/ -name 'google-*')" ]; then
  sudo wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/ubuntu/google-chrome-beta.list -P /etc/apt/sources.list.d/
fi
sudo apt-get update
sudo apt-get install -y google-chrome-beta

## retrieve git and vim settings
curl https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/gitVimNORMALorROOT.sh | sh

if [ `which unity` ]; then
  wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/ubuntu/.unitySetup.sh -P ~/; bash ~/.unitySetup.sh
fi

## configure kde if present (kubuntu)
if [ `which startkde` ]; then
  curl https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/kdeSetup.sh | bash
fi

## set vim as the default editor
if [ -z "$(grep -r 'EDITOR' /etc/profile.d/ && grep -r 'EDITOR' /etc/profile)" ]; then
  if [ ! -e /etc/profile.d/vimDefault ]; then
    sudo sh -c 'echo >> /etc/profile.d/vimDefault'
    sudo sh -c 'echo "export EDITOR=vim" >> /etc/profile.d/vimDefault'
    sudo sh -c 'echo "export VISUAL=vim" >> /etc/profile.d/vimDefault'
    sudo sh -c 'echo >> /etc/profile.d/vimDefault'
  fi
fi

## restart unity so all our settings take effect
##if [ "$(pgrep unity)" ]; then
  ##unity --replace
##fi

echo
echo "    .--. "
echo "   |o_o | "
echo "   |:_/ | "
echo "  //   \ \ "
echo " (|     | ) "
echo "/'\_   _/'\ "
echo "\___)=(___/ "
echo
echo "A reboot may be necessary."
echo

