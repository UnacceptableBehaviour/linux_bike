# Context
## Status: Initialise FONA get SOC status, network status etc
[AMBER]

## Contents
1. [Status: Initialise FONA get SOC status, network status etc](#status-initialise-fona-get-soc-status-network-status-etc)
2. [Contents](#contents)
3. [Next steps](#next-steps)
4. [Completed](#completed)
	1. [Get serial comms talking and FONA unit response\](#get-serial-comms-talking-and-fona-unit-response)
	2. [Wire up a raspberry pi zero to FONA GPS/Comms module](#wire-up-a-raspberry-pi-zero-to-fona-gpscomms-module)
	3. [AC/DC converter mounting asembly (STL 3d print assmbly, fit)](#acdc-converter-mounting-asembly-stl-3d-print-assmbly-fit)
	4. [Battery casing and assembly (internal cell assembly, STL 3d print casing)](#battery-casing-and-assembly-internal-cell-assembly-stl-3d-print-casing)
	5. [Battery life tests](#battery-life-tests)
	6. [Create simple linux platform allow ruby/python and SSH (use a raspberry pi - rpi)](#create-simple-linux-platform-allow-rubypython-and-ssh-use-a-raspberry-pi--rpi)
	7. [Install os on rpi & make it visible on network, and ssh in.](#install-os-on-rpi--make-it-visible-on-network-and-ssh-in)
5. [How To's](#how-tos)
	1. [How do I insert a TOC?](#how-do-i-insert-a-toc)
	2. [How do I auto generate TOC?](#how-do-i-auto-generate-toc)
6. [Q's & Barriers](#qs--barriers)
7. [TIPS](#tips)
8. [REFERENCES](#references)
	1. [Markdown cheat sheet](#markdown-cheat-sheet)
	2. [GFM - Git Flavoured Markdown](#gfm--git-flavoured-markdown)


## Next steps
Initialise FONA get SOC status, network status etc\
Re-org this context to it better complies with the template\
Populate this repo with info about completed steps\
Get wifi dongle working so can us LAN dongle for other things!\
Add docs and files for completed steps, directory for each?\
Ugrade TOC script so it inserts TOC back into .md file and saves new version into scratch folder

## Completed
### Get serial comms talking and FONA unit response\
```/ruby/serial/serial_tests_tty2FONA.rb```

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


## How To's
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

### How do I auto generate TOC?
```
$ cd /lang/linux_mix/linux_bike             # cd into repo - same dir as the README.md file
                                            # or context.md file
$ spe                                       # venv for python scrips
                                            # alias spe='. /repos/python_scripts/venv/bin/activate'   
$ create_TOC_for_md.py                      # run script
                                            # paste output into .md file TOC
```



## Q's & Barriers





## TIPS
Keep status concise:\
start w/ RED, AMBER, GREEN (colours report box)\

<br>/CRLF in markdown is endline \\


## REFERENCES
### Markdown cheat sheet
https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

### GFM - Git Flavoured Markdown
https://github.github.com/gfm/
