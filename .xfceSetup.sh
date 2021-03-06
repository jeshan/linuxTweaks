#!/bin/sh

## curl https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.xfceSetup.sh | sh

## thanks to @bfanning
## only one panel!
xfconf-query -n -a -c xfce4-panel -p /panels -t int -s 0
## this has to match the number of plugins below
xfconf-query --create --channel xfce4-panel --property /panels/panel-0/plugin-ids \
  --type int --type int --type int --type int --type int --type int --type int \
  --set 1 --set 2 --set 3 --set 4 --set 5 --set 6 --set 7
xfconf-query -n -c xfce4-panel -p /panels/panel-0/length -t int -s 100
xfconf-query -n -c xfce4-panel -p /panels/panel-0/size -t int -s 32
xfconf-query -n -c xfce4-panel -p /panels/panel-0/position -t string -s "p=6;x=0;y=0"
xfconf-query -n -c xfce4-panel -p /panels/panel-0/position-locked -t bool -s true

## pretty much xfce defaults
xfconf-query -n -c xfce4-panel -p /plugins/plugin-1 -t string -s applicationsmenu
xfconf-query -n -c xfce4-panel -p /plugins/plugin-2 -t string -s tasklist
xfconf-query -n -c xfce4-panel -p /plugins/plugin-3 -t string -s separator
xfconf-query -n -c xfce4-panel -p /plugins/plugin-4 -t string -s pager
xfconf-query -n -c xfce4-panel -p /plugins/plugin-5 -t string -s clock
xfconf-query -n -c xfce4-panel -p /plugins/plugin-6 -t string -s systray
xfconf-query -n -c xfce4-panel -p /plugins/plugin-7 -t string -s pulseaudio

## make the top panel beautiful
## applications menu
xfconf-query -n -c xfce4-panel -p /plugins/plugin-1/show-button-title -t bool -s false
## separator
xfconf-query -n -c xfce4-panel -p /plugins/plugin-3/style -t int -s 0
xfconf-query -n -c xfce4-panel -p /plugins/plugin-3/expand -t bool -s true
## window/task list
xfconf-query -n -c xfce4-panel -p /plugins/plugin-2/show-labels -t bool -s false
## workspace pager,
## i call this the "Theodore Ts'o" layout
xfconf-query -n -c xfce4-panel -p /plugins/plugin-4/rows -t int -s 3
xfconf-query -n -c xfce4-panel -p /plugins/plugin-4/miniature-view -t bool -s true
xfconf-query -n -c xfwm4 -p /general/workspace_count -t int -s 9
## clock (fuzzy mode)
xfconf-query -n -c xfce4-panel -p /plugins/plugin-5/show-frame -t bool -s false
xfconf-query -n -c xfce4-panel -p /plugins/plugin-5/mode -t int -s 3
## systray
xfconf-query -n -c xfce4-panel -p /plugins/plugin-6/show-frame -t bool -s false

## make window management awesome
xfconf-query -n -c xfwm4 -p /general/snap_to_border -t bool -s true
xfconf-query -n -c xfwm4 -p /general/snap_to_windows -t bool -s true
xfconf-query -n -c xfwm4 -p /general/wrap_windows -t bool -s false
xfconf-query -n -c xfwm4 -p /general/wrap_workspaces -t bool -s false
xfconf-query -n -c xfwm4 -p /general/click_to_focus -t bool -s false

## make touchpad awesome
xfconf-query -n -c pointers -p /SynPS2_Synaptics_TouchPad/Properties/Synaptics_Edge_Scrolling -t int -s 0 -t int -s 0 -t int -s 0
xfconf-query -n -c pointers -p /SynPS2_Synaptics_TouchPad/Properties/Synaptics_Tap_Action -t int -s 0 -t int -s 0 -t int -s 0 -t int -s 0 -t int -s 0 -t int -s 0 -t int -s 0
xfconf-query -n -c pointers -p /SynPS2_Synaptics_TouchPad/Properties/Synaptics_Two-Finger_Scrolling -t int -s 1 -t int -s 1

## become the flash
xfconf-query -n -c keyboards -p /Default/KeyRepeat/Delay -t int -s 150
xfconf-query -n -c keyboards -p /Default/KeyRepeat/Rate -t int -s 80

## enable font anti-aliasing
xfconf-query -n -c xsettings -p /Xft/Antialias -t int -s 1

## i love terminus!
xfconf-query -n -c xsettings -p /Gtk/FontName -t string -s "Terminus 14"

## we need the terminal quickly!
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>t" -t string -s /usr/bin/xfce4-terminal

## screenshots for all!
## grab my screenshot save script:
## https://github.com/ryanpcmcquen/linuxTweaks/blob/master/xfceScreenshotSaver
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/Print" -t string -s "xfce4-screenshooter -f -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Alt>Print" -t string -s "xfce4-screenshooter -w -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary>Print" -t string -s "xfce4-screenshooter -r -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/Print1" -t string -s "xfce4-screenshooter -d 1 -f -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/Print2" -t string -s "xfce4-screenshooter -d 2 -f -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/Print3" -t string -s "xfce4-screenshooter -d 3 -f -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/Print4" -t string -s "xfce4-screenshooter -d 4 -f -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/Print5" -t string -s "xfce4-screenshooter -d 5 -f -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/Print6" -t string -s "xfce4-screenshooter -d 6 -f -m -o xfceScreenshotSaver"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/Print7" -t string -s "xfce4-screenshooter -d 7 -f -m -o xfceScreenshotSaver"

## thanks to @bmaupin
## configure keyboard shortcuts for moving windows to different workspaces
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Shift><Alt>Down" -t string -s "move_window_down_workspace_key"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Shift><Alt>Left" -t string -s "move_window_left_workspace_key"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Shift><Alt>Right" -t string -s "move_window_right_workspace_key"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Shift><Alt>Up" -t string -s "move_window_up_workspace_key"

## make the desktop tidy
xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -t bool -s false
xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-home -t bool -s false
xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -t bool -s false

## remove annoying defaults
xfconf-query -n -c xfce4-session -p /general/SaveOnExit -t bool -s false
xfconf-query -n -c xfce4-session -p /splash/Engine -t string -s mice

## ooh, the power!
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-ac -t int -s 1
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-battery -t int -s 1

## disable screensaver
## this command does not work, but it looks good:
xfconf-query -n -c xfce4-session -p /startup/screensaver/enabled -t bool -s false
## this is what actually disables the screensaver
mkdir -pv ~/.config/autostart/
cat <<EOT > $HOME/.config/autostart/xscreensaver.desktop
[Desktop Entry]
Hidden=true
EOT

## and we'll kill it for the current session as well
if [ "`which xscreensaver-command`" ]; then
  xscreensaver-command -exit
fi

## make the terminal groovier
if [ -e ~/.config/xfce4/terminal/terminalrc ]; then
  if [ -z "$(grep 'FontName\=Terminus\ 14' ~/.config/xfce4/terminal/terminalrc)" ]; then
    sed -i.bak 's@FontName\=.*@FontName\=Terminus\ 14@g' ~/.config/xfce4/terminal/terminalrc
  fi
  if [ -z "$(grep 'MiscDefaultGeometry\=120x40' ~/.config/xfce4/terminal/terminalrc)" ]; then
    sed -i.bak 's@MiscDefaultGeometry\=.*@MiscDefaultGeometry\=120x40@g' ~/.config/xfce4/terminal/terminalrc
  fi
  if [ -z "$(grep 'BackgroundMode\=TERMINAL_BACKGROUND_TRANSPARENT' ~/.config/xfce4/terminal/terminalrc)" ]; then
    sed -i.bak 's@BackgroundMode\=.*@BackgroundMode\=TERMINAL_BACKGROUND_TRANSPARENT@g' ~/.config/xfce4/terminal/terminalrc
  fi
  if [ -z "$(grep 'BackgroundDarkness\=0.800000' ~/.config/xfce4/terminal/terminalrc)" ]; then
    sed -i.bak 's@BackgroundDarkness\=.*@BackgroundDarkness\=0.800000@g' ~/.config/xfce4/terminal/terminalrc
  fi
else
  mkdir -pv ~/.config/xfce4/terminal/
  echo "[Configuration]" >> ~/.config/xfce4/terminal/terminalrc
  echo "FontName=Terminus 14" >> ~/.config/xfce4/terminal/terminalrc
  echo "MiscDefaultGeometry=120x40" >> ~/.config/xfce4/terminal/terminalrc
  echo "BackgroundMode=TERMINAL_BACKGROUND_TRANSPARENT" >> ~/.config/xfce4/terminal/terminalrc
  echo "BackgroundDarkness=0.800000" >> ~/.config/xfce4/terminal/terminalrc
fi


