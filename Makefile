
.PHONY: run

all: run

build:
	cd ./mruby && ./minirake

run: test/app.rb
	./mruby/build/host/bin/mirb test/app.rb
