#!/usr/bin/env bash
set -e

info="\033[0;32m==> info ]\033[0m"
warning="\033[0;33m==> warn ]\033[0m"
error="\033[0;31m==> error ]\033[0m"

check_root() {
  if [[ $EUID -ne 0 ]]; then
      echo -e "$error This script must be run as root\n$info You could also run: sudo $0" 1>&2
      exit 1
  fi
}

detect_osx_version() {
  result=`sw_vers -productVersion`

  if [[ $result =~ "10.8" ]]; then
      osxversion="10.8"
      osxvername="Mountain Lion"
      cltools=command_line_tools_os_x_mountain_lion_for_xcode__october_2013.dmg
      mountpath="/Volumes/Command Line Tools (Mountain Lion)"
      mpkg="Command Line Tools (Mountain Lion).mpkg"
      pkg_url="https://dl.dropboxusercontent.com/u/16710641/command_line_tools_os_x_mountain_lion_for_xcode__october_2013.dmg"
      pkgmd5="514e307c6e7e0744b30f6e2d53e90f7a"
      #downloaded from: https://developer.apple.com/downloads/
  else
      echo -e "$error This machine is running an unsupported version of OS X" 1>&2
      exit 1
  fi

  echo -e "$info Detected OS X $osxversion $osxvername"
}

check_tools() {
  RECEIPT_FILE=/var/db/receipts/com.apple.pkg.DeveloperToolsCLI.bom
  if [ -f "$RECEIPT_FILE" ]; then 
    echo -e "$info Command Line Tools are already installed. Exiting..." 
    exit 0
  fi
}

download_tools () {
  # i changed to curl from wget since wget isn't always on a fresh install
  if [ -f /tmp/$cltools ]; then
    # indirmd5=`md5 -q /tmp/$cltools`
    if [ `md5 -q /tmp/$cltools` = "${pkgmd5}" ]; then
      echo -e "$info $cltools already downloaded to /tmp/$cltools."
    else
       rm -f /tmp/$cltools
    fi
  else
    cd /tmp && curl "$pkg_url" -o "$cltools"
  fi
}

install_tools() {
  # Mount the Command Line Tools dmg
  echo -e "$info Mounting Command Line Tools..."
  hdiutil mount -nobrowse /tmp/$cltools
  # Run the Command Line Tools Installer
  echo -e "$info Installing Command Line Tools..."
  installer -pkg "$mountpath/$mpkg" -target "/Volumes/Macintosh HD"
  # Unmount the Command Line Tools dmg
  echo -e "$info Unmounting Command Line Tools..."
  hdiutil unmount "$mountpath"

  gcc_bin=`which gcc`
  gcc --version &>/dev/null && echo -e "$info gcc found in $gcc_bin"
}
 
cleanup () {
  rm /tmp/$cltools
  echo -e "$info Cleanup complete."
  exit 0
}

main() {
  check_root
  # Detect and set the version of OS X for the rest of the script
  detect_osx_version
  # Check for if tools are already installed by looking for a receipt file
  check_tools
  # Check for and if necessary download the required dmg
  download_tools
  # Start the appropriate installer for the correct version of OSX
  install_tools
  # Cleanup files used during script
  cleanup
}

main
