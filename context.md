# Context
## Status: getting FONA hadshake to work
[AMBER]

## Contents
1. [Status: getting FONA hadshake to work](#status-getting-fona-hadshake-to-work)\
2. [Contents](#contents)\
3. [Next steps](#next-steps)\
4. [Completed](#completed)\
	1. [Wire up a raspberry pi zero to FONA GPS/Comms module](#wire-up-a-raspberry-pi-zero-to-fona-gpscomms-module)\
	2. [AC/DC converter mounting asembly (STL 3d print assmbly, fit)](#acdc-converter-mounting-asembly-stl-3d-print-assmbly-fit)\
	3. [Battery casing and assembly (internal cell assembly, STL 3d print casing)](#battery-casing-and-assembly-internal-cell-assembly-stl-3d-print-casing)\
	4. [Battery life tests](#battery-life-tests)\
	5. [Create simple linux platform allow ruby/python and SSH (use a raspberry pi - rpi)](#create-simple-linux-platform-allow-rubypython-and-ssh-use-a-raspberry-pi--rpi)\
	6. [Install os on rpi & make it visible on network, and ssh in.](#install-os-on-rpi--make-it-visible-on-network-and-ssh-in)\
	7. [How do I insert a TOC?](#how-do-i-insert-a-toc)\
5. [Q's & How To's](#qs--how-tos)\
		1. [How do I auto generate TOC?](#how-do-i-auto-generate-toc)\
6. [TIPS](#tips)\
7. [REFERENCES](#references)\
	1. [Markdown cheat sheet](#markdown-cheat-sheet)\
	2. [GFM - Git Flavoured Markdown](#gfm--git-flavoured-markdown)\


## Next steps
Get serial comms talking and FONA unit response\
Get wifi so can us LAN dongle forother things!\
Add docs and files for completed steps, directory for each?\

## Completed
### Wire up a raspberry pi zero to FONA GPS/Comms module
Add wiring diagram and notes on important pins.\

### AC/DC converter mounting asembly (STL 3d print assmbly, fit)
Add mechanical diagram\
Add sketchup, STL, and gcode files\
Add image of Prototype mounting\

### Battery casing and assembly (internal cell assembly, STL 3d print casing)
Add mechanical diagram\
Add sketchup, STL, and gcode files\
Add image of assembly stages\
Comment possible flaws and potential redisign from prototype v1\

### Battery life tests
Basic workings\
Power consumption per module\

### Create simple linux platform allow ruby/python and SSH (use a raspberry pi - rpi)
Intsalling / compiling ruby for SD platform image\

### Install os on rpi & make it visible on network, and ssh in.
Doc about setting up the rpi for remote development\

### How do I insert a TOC?
To creat a link to a chapter in MD:
```
[Text to Display](#text-from-title)\
[Q's & How To's](#qs--how-tos)\
```

The text-from-title is the the text from the title downcased, with spaces replaced with a hyphen '-' and non alphanumeric characters removed. So "Q's & How To's" becomes '#qs--how-tos'
The '\\' at the end of the line is same as <br> or CRLF. (New line)

To create a TOC, create a numbered list of links. Tab in next level with new numbers.
```
1. [Current status](#status)\
2. [Contents](#contents)\
3. [Next steps](#next-steps)\
4. [Completed](#completed)\
5. [Q's & How To's](#qs--how-tos)\
1. [Adding tabs to content links](#adding-tabs-to-content-links) \
2. [Auto generaging TOC](#auto-generaging-toc)\
6. [Tips on context doc](#tips)\
7. [References](#references)
```


## Q's & How To's
#### How do I auto generate TOC?
REF: https://github.com/isaacs/github/issues/215/


## TIPS
Keep status concise:\
start w/ RED, AMBER, GREEN (colours report box)\

<br>/CRLF in markdown is endline \\


## REFERENCES
### Markdown cheat sheet
https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

### GFM - Git Flavoured Markdown
https://github.github.com/gfm/
