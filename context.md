# context
## status: getting FONA hadshake to work
[AMBER]

## Contents
1. [Current status](#status)\
2. [Contents](#contents)\
3. [Next steps](#next-steps)\
4. [Completed](#completed)\
5. [Q's & How To's](#qs--how-tos)\
    1. [Adding tabs to content links](#adding-tabs-to-content-links) \
    2. [Auto generaging TOC](#auto-generaging-toc)\
6. [Tips on context doc](#tips)\
7. [References](#references)


## Next steps
Get serial comms talking and FONA unit response
Get wifi so can us LAN dongle forother things!
Add docs and files for completed steps, directory for each?

## Completed
### Wire up a raspberry pi zero to FONA GPS/Comms module\

### AC/DC converter mounting asembly (STL 3d print assmbly, fit)\

### Battery casing and assembly (internal cell assembly, STL 3d print casing)\

### Battery life tests\

### Create simple linux platform allow ruby/python and SSH (use a raspberry pi - rpi)\

### Install os on rpi & make it visible on network, and ssh in.\

### How do I insert a TOC?
To creat a link to a chapter in MD:
```
[Text to Display](#text-from-title)\
[Q's & How To's](#qs--how-tos)\
```

The text-from-title is the the text from the title downcased, with spaces replaced with a hyphen '-' and non alphanumeric characters removed. So "Q's & How To's" becomes '#qs--how-tos'
The '\' at the end of the line is same as <br> or CRLF. (New line)

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
#### How do I uuto generate TOC?
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
