note from charle5: i ripped this off from the guy referenced below and modified for me. the main differences are:
1. 10.8.x only instead of also 10.7.x
2. wget has been replaced w/ curl (so this can be used on fresh installs)

xcode-cli-install
=================

A script to install (&amp; remove) xcode462_cltools for Lion &amp; mountain Lion
Inspired by a [blog post](http://blog.smalleycreative.com/administration/automating-osx-part-one/)

I stored both xcode version in DropBox - so I hope I won't be forced to remove them, the reason they are there is that
you cannot download without an Apple userid and pass which takes the juice out of automating a laptop boot strapping.

If you just want the dmg's click on [Mountain Lion](https://dl.dropboxusercontent.com/u/16710641/command_line_tools_os_x_mountain_lion_for_xcode__october_2013.dmg)

## Usage [ when used standalone ]
	sudo bash < <(curl -L https://raw.github.com/charle5/xcode-cli-install/master/install.sh)
## Uninstalling [ when used standalone ]
	sudo bash < <(curl -L https://raw.github.com/charle5/xcode-cli-install/master/uninstall.sh)
**This is 1 of a series of tools/utils to automate your macosx workstation setup**

## License 
(The MIT License)

Copyright &copy; 2013 Haggai Philip Zagury. See [LICENSE][:lic] file for more details.

Enjoy
HP