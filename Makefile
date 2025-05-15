# Makefile for ckube project

.PHONY: build clean install

build:
	@mkdir -p bin
	@go build -o bin/ckube ./src/main.go

clean:
	@rm -rf bin

install: build
	@cp bin/ckube /usr/local/bin/
	@chmod +x /usr/local/bin/ckube
	@echo "ckube installed to /usr/local/bin/"
	@echo "You can now use it with kubectl by running 'kubectl columns'"
	@echo "Make sure to add /usr/local/bin to your PATH if it's not already there."
	@echo "You can also run it directly from the bin directory by running './bin/ckube'"
	@echo "To uninstall, simply remove /usr/local/bin/ckube"