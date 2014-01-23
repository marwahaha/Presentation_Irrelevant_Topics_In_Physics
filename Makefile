title  = "Irrelevant Topics In Physics"
author = "Travis Hoppe"
target = "irr_topics_8.md"

python_exec    = python
md2reveal_exec = md2reveal/md2reveal.py

# May need to run twice on first pull to copy styles
args = --html_title $(title) --html_author $(author) 
all:
	$(python_exec) $(md2reveal_exec) $(target) --output index.html $(args)

edit:
	emacs $(target) &

commit:
	@-make push

check:
	aspell -c -H $(target)

push:
	git status
	git add index.html Makefile
	git add $(target)
	git add *.md
	git commit -a
	git push

pull:
	git pull
	git submodule foreach git pull origin master

view:
	chromium-browser index.html
clean:
	rm -rvf index.html

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
