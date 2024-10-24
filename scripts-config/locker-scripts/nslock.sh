#!/usr/bin/env bash
# nslock
# a simple locker for wiredWM (wayland) which uses swaylock and a custom image and the nightshadeNeon color scheme.
img="$HOME/wiredWM/wp/lain-machine.png"
ringcolor="#ff10f0"
ringvercolor="#39ff14"
textvercolor="#ffffff"
swaylock --image "$img" --ring-color "$ringcolor" --ring-ver-color "$ringvercolor" --text-ver-color "$textvercolor"
