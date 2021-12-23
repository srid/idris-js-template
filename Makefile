
idrisid:
	@echo "Launching idrisid"
	pwd
	echo main.idr | entr sh -c 'make build'

build:	build/exec/main.js

build/exec/main.js:	main.idr 
	idris2 -o main.js main.idr --cg javascript

web:
	live-server