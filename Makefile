.PHONY: serve
serve:
	webdev serve

.PHONY: dev
dev:
	npx tailwindcss -i ./web/styles.css -o ./web/dist/output.css

.PHONY: build
build: webdev-build build-tailwindcss

.PHONY: webdev-build
webdev-build: 
	mkdir build || true
	webdev build

.PHONY: build-tailwindcss
build-tailwindcss:
	npx tailwindcss -i ./build/styles.css -o ./build/dist/output.css
	
.PHONY: init
init:
	mkdir build || true
	cd build && npx tailwindcss init
	npm i
	