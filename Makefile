title  = "Irrelevant Topics In Physics"
author = "Travis Hoppe"
target = "irr8"

markdown_file = talks/$(target).md

python_exec    = python
md2reveal_exec = md2reveal/md2reveal.py

args = --html_title $(title) --html_author $(author) 
all:
	$(python_exec) $(md2reveal_exec) $(markdown_file) --output index.html $(args)

edit:
	emacs $(markdown_file) &

check:
	aspell -c -H $(markdown_file)

view:
	chromium-browser index.html

commit:
	@-make push

clean:
	rm -rvf index.html

push:
	git status
	git add index.html Makefile README.md
	git add talks/*.md
	git commit -a
	git push

pull:
	git pull
	git submodule foreach git pull origin master

#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=
# Build dependencies
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=

build_deps:
	-@make build_reveal.js
	-@make build_md2reveal
	git submodule init 
	git submodule update

build_reveal.js:
	-@git submodule add https://github.com/hakimel/reveal.js.git reveal.js

build_md2reveal:
	-@git submodule add https://github.com/thoppe/md2reveal md2reveal
