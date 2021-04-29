#!/usr/bin/env bash

echo "Fixing function keys under Linux for keychron keyboards"
echo "See https://mikeshade.com/posts/keychron-linux-function-keys/"
echo ""
echo "Instructions"
echo "1. Set the keyboard to Windows mode via the side switch"
echo "2. Use fn + X + L (hold for 4 seconds) to set the function key mode."
echo ""
echo "Did you do this so far? If yes, press any key to continue!"
read

echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo "options hid_apple fnmode=0" | sudo tee -a /etc/modprobe.d/hid_apple.conf

# Ubuntu
sudo update-initramfs -u

# Arch
# mkinitcpio -P
