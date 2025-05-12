# Makefile for kubectl-columns project

.PHONY: build clean install

build:
	@mkdir -p bin
	@go build -o bin/kubectl-columns ./src/main.go

clean:
	@rm -rf bin

install: build
	@cp bin/kubectl-columns /usr/local/bin/
	@chmod +x /usr/local/bin/kubectl-columns
	@echo "kubectl-columns installed to /usr/local/bin/"
	@echo "You can now use it with kubectl by running 'kubectl columns'"
	@echo "Make sure to add /usr/local/bin to your PATH if it's not already there."
	@echo "You can also run it directly from the bin directory by running './bin/kubectl-columns'"
	@echo "To uninstall, simply remove /usr/local/bin/kubectl-columns"