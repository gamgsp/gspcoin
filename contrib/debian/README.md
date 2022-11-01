
Debian
====================
This directory contains files used to package gspcoind/gspcoin-qt
for Debian-based Linux systems. If you compile gspcoind/gspcoin-qt yourself, there are some useful files here.

## gspcoin: URI support ##


gspcoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install gspcoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your gspcoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/gspcoin128.png` to `/usr/share/pixmaps`

gspcoin-qt.protocol (KDE)

