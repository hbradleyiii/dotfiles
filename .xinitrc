# Brother Scanner service
brscan-skey
# dropbox
nautilus --no-desktop -n &
numlockx &
xmodmap ~/.Xmodmap
xrdb ~/.Xresources
xsetroot -cursor_name left_ptr
feh --no-xinerama --no-fehbg --image-bg black --bg-max '/home/harold/Pictures/wallpaper/mountains-01.jpg' &
trayer --edge top --align right --margin 1 --width 10 --height 25 --SetDockType true --SetPartialStrut true --transparent true --alpha 255 --padding 1 &
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xmonad > $HOME/.xmonad/log.txt 2>&1
