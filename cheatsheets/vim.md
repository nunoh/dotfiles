# My vim cheat sheet

so that I don't forget them :relaxed:

### Text objects stuff

	dl	 delete character (alias: "x")
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


### Basics

	d$	delete until end of line
	D	delete until end of line
	y	yank until end of line

	zg	add word under cursor to dictionary

### Changing case

	gu{movement}
	gU{movement}


### Folds

	zo	open fold
	zc	close fold	
	zM  close all folds
	zR	open all folds


### Moving cursor around

	z.	put the line with the cursor in the center of the screen
	z<CR> igual
	zt	put the line with the cursor in the top of the screen
	zb	put the line with the cursor in the bottom of the screen


### Windows

	C-W-r switch windows


### File Stuff

	gf	open file under cursor in the same window
	<C-W>f open file under curosr in a new window
