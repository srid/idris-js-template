
all:	build/exec/hello_app/hello.so
	build/exec/hello_app/hello.so

build/exec/hello_app/hello.so:	hello.idr 
	idris2 hello.idr -o hello 
