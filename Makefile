
all:	build/exec/hello
	./build/exec/hello

build/exec/hello:	hello.idr 
	@echo "Building hello"
	idris2 hello.idr -o hello