dots=$(wildcard *.dot)
svgs=$(dots:%.dot=%.svg)


.SUFFIXES: .svg .dot
.dot.svg:
	@echo Making $<
	@dot -Tsvg $< > $@


.PHONY: default
default:
	@echo "No default targets. Use one of the following:"
	@grep "^# target" Makefile


# target: svg -- make svgs
.PHONY: svg
svg: $(svgs) make2dot make.svg


# target: open -- open svgs in browser
.PHONY: open
open: $(svgs) make.svg
	open $^


# target: clean -- remove svgs
.PHONY: clean
clean: $(svgs)
	@echo delete: $^
	@rm $^


# target: make2dot -- generates a dot file from a makefile
.PHONY: make2dot
make2dot: bin/make2dot Makefile make.dot
make.dot:
	@echo Making $@ from Makefile..
	@cat Makefile | grep "^[a-z0-9./%]*:" | tr -d ":" | bin/make2dot > make.dot
