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
svg: $(svgs)


# target: open -- open svgs in browser
.PHONY: open
open: $(svgs)
	open $^


# target: clean -- remove svgs
.PHONY: clean
clean: $(wildcard *.svg)
	@echo delete: $^
	@rm $^
