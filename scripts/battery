#!/bin/sh

upower -i /org/freedesktop/UPower/devices/battery_BAT0 |
grep percentage |
sed -r 's/ +//g' |
cut -d':' -f2
