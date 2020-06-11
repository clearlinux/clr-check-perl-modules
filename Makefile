all: build

build:
	$(MAKE) -C src build

install:
	$(MAKE) -C src install
