# Makefile for automating builds of a web project
#
# Copyright 2015 Jonathan Bowman. Licensed under the Apache License,
# Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
# distributed "AS IS" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND

# Command for serving files
HTTP_SERVER = hugo server -Dw

GENERATE_CMD = hugo

# target file for bundled Javascript
JS_TARGET = public/assets/bundle.js

# Source directory
SRC_DIR = src

# Javascript source directory
JS_DIR = $(SRC_DIR)/js

# command for error-checking Javascript
JS_LINT_CMD = eslint $(JS_DIR)

# Javascript file to be passed to bundler as entry point
MAIN_JS = $(JS_DIR)/main.js

# Command for Javascript minification
# Default uses Taco de Wolff's minify; also used for CSS minification below.
# https://github.com/tdewolff/minify/tree/master/cmd/minify
MINIFY_JS_CMD = minify -x .js > $(JS_TARGET)

# Command for Javascript bundling
# default: http://browserify.org/
BUNDLE_JS_CMD = browserify $(MAIN_JS) | $(MINIFY_JS_CMD)

# Command for watching Javascript files and bundling on the fly
# default: https://github.com/substack/watchify
WATCH_JS_CMD = watchify $(MAIN_JS) -o "$(MINIFY_JS_CMD)" -v

# target css file (Sass compiler output)
CSS_TARGET = public/assets/main.css

# directory in which Sass files reside (to be compiled)
SASS_DIR = $(SRC_DIR)/sass

# Command for compiling (and minifying if desired) Sass to CSS.
# Default uses Wellington: http://getwt.io/
SASS_CMD = wt compile --comment=false $(MAIN_SASS) | minify -x .css -o $(CSS_TARGET)

# Sass file to be passed to compiler (may import other Sass and CSS)
MAIN_SASS = $(SASS_DIR)/main.scss

# list of Sass and CSS files to compile (basically a recursive directory search for .scss and .css files)
SASS_FILES = $(wildcard $(SASS_DIR)/*css $(SASS_DIR)/**/*css)

# Default MAKEFLAGS, so they don't need to be passed on the command-line.
# -j is necessary for parallel processes (for the watch target); --silent 
# and --ignore-errors together suppress error output, which is done 
# primarily for the "watch" targets. Without this, CTRL-C (Keyboard 
# interrupt) will emit errors, which are confusing and bothersome
MAKEFLAGS := --silent --ignore-errors -j

watch: watch-css watch-js serve

build: build-css build-js generate

lint: lint-js

lint-js:
	$(JS_LINT_CMD)

$(CSS_TARGET): $(SASS_FILES)
	$(SASS_CMD)

generate:
	$(GENERATE_CMD)

build-css: $(CSS_TARGET)

watch-css:
	while sleep .5; do find $(SASS_DIR) -name "*css" -print | entr -d $(SASS_CMD); done

$(JS_TARGET): $(MAIN_JS)
	$(BUNDLE_JS_CMD)

build-js: $(JS_TARGET) 

watch-js:
	$(WATCH_JS_CMD)

serve:
	$(HTTP_SERVER)

.PHONY: build-css watch-css build-js watch-js serve build watch

