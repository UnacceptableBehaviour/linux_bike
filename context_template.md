# Context
## Status: project current status
[AMBER]

## Contents
1. [Status: project current status](#status-project-current-status)
2. [Contents](#contents)
3. [Next steps](#next-steps)
4. [Completed](#completed)
5. [How To's](#how-tos)
	1. [How do I insert a TOC?](#how-do-i-insert-a-toc)
6. [Questions / Barriers](#questions--barriers)
	1. [How do we pull load info from the sheduler, are there OS hooks?\](#how-do-we-pull-load-info-from-the-sheduler-are-there-os-hooks)
	2. [Can personality emerge for a set of competing algorithms?\](#can-personality-emerge-for-a-set-of-competing-algorithms)
	3. [What is the best way to achieve hyper focus?\](#what-is-the-best-way-to-achieve-hyper-focus)
	4. [How do I auto generate TOC?](#how-do-i-auto-generate-toc)
7. [TIPS](#tips)
8. [REFERENCES](#references)
	1. [Markdown cheat sheet](#markdown-cheat-sheet)
	2. [GFM - Git Flavoured Markdown](#gfm--git-flavoured-markdown)


## Next steps
Action 1\
Action 2 - on Critical Path\
Action 3 etc\


## Questions / Barriers
### How do we pull load info from the sheduler, are there OS hooks?\
### Can personality emerge for a set of competing algorithms?\
### What is the best way to achieve hyper focus?\


## Completed
2019.Jul.31 - TLA - Create Context Template - Move to bottom?



## How To's
### How do I insert a TOC?
To create a link to a chapter in MD:
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
Available here: [create_TOC_for_md.py](https://github.com/UnacceptableBehaviour/python_scripts/blob/master/create_TOC_for_md.py)  


## TIPS
Keep status concise:  
Put the colour in square brackets on the next line immediately after status  
RED   - Stalled, technology/cost barrier.
AMBER - Work in progress.
GREEN - Complete.
BLUE  - Parked, no action planned. (maybe incomplete / redundant)

<br>/CRLF in markdown is endline \\


## REFERENCES
### Markdown cheat sheet
https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

### GFM - Git Flavoured Markdown
https://github.github.com/gfm/
