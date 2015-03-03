#! /bin/bash

echo "This shell script convert OS X Mavericks(10.9) to install iso file"
echo "Copyright 2011-2014 RTX1911"

hdiutil attach /Applications/Install\ OS\ X\ Mavericks.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app
hdiutil convert /Volumes/install_app/BaseSystem.dmg -format UDSP -o /tmp/Mavericks
hdiutil resize -size 8g /tmp/Mavericks.sparseimage
hdiutil attach /tmp/Mavericks.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build
rm /Volumes/install_build/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/install_build/System/Installation/
hdiutil detach /Volumes/install_app
hdiutil detach /Volumes/install_build
hdiutil resize -size `hdiutil resize -limits /tmp/Mavericks.sparseimage | tail -n 1 | awk '{ print $1 }'`b /tmp/Mavericks.sparseimage
hdiutil convert /tmp/Mavericks.sparseimage -format UDTO -o /tmp/Mavericks
rm /tmp/Mavericks.sparseimage
mv /tmp/Mavericks.cdr ~/Desktop/Mavericks.iso

echo "Done!"