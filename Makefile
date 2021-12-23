
all:	build/exec/main.js

build/exec/main.js:	main.idr 
	idris2 -o main.js main.idr --cg javascript

run:
	live-server