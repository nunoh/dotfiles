# My vim cheat sheet

so that I don't forget them :relaxed:

### Text objects stuff

	dl   delete character (alias: "x")
	diw  delete inner word
	daw  delete a word
	diW  delete inner WORD
	daW  delete a WORD
	dgn  delete the next search pattern match
	dd   delete one line
	dis  delete inner sentence
	das  delete a sentence
	dib  delete inner '(' ')' block
	dab  delete a '(' ')' block
	dip  delete inner paragraph
	dap  delete a paragraph
	diB  delete inner '{' '}'
	daB  delete a '{' '}'


### Navigating

	C-O jump backward
	C-I jump forward


### Searching 

	#	search for word under the cursor

### Basics

	d$	delete until end of line
	D	delete until end of line
	y	yank until end of line

	zg	add word under cursor to dictionary


### Changing case

	gu{movement}
	gU{movement}


### Folds

    zi  enable/disable folding

	zo	open fold
	zO	open fold recursively

	zc	close fold	
	zC	close fold recursively

	zM  close all folds
	zR	open all folds


### Moving cursor around

	z.	put the line with the cursor in the center of the screen
	z<CR> igual
	zt	put the line with the cursor in the top of the screen
	zb	put the line with the cursor in the bottom of the screen


### Windows

	C-W-r switch windows (the cursor)
	C-W x swtich the buffer of the windows
	C-W=  resize splits evenly


### File Stuff

	gf	open file under cursor in the same window
	<C-W>f open file under curosr in a new window

### Misc

Inserting any unicode character in VIM. (while in insert mode, cause otherwise goes to visual-block)

    <C-v>u25b8

Start vim without any configuration, vanilla vim:

    $ vim -u NONE

Join lines

    S-j

### Command line

C-B     go to beginning of the line
C-E     go to the end of the line
C-P     go to the previous command entered
C-N     go to the next command entered

### 

Insert in paste mode (from clipboard)

   <C-r>*
