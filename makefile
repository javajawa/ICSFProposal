TARGET_BASENAMES = proposal
SOURCE_FILES = $(wildcard **/*.latex)
FIGURES = $(wildcard figures/*)

.DEFAULT: all
.SUFFIXES:
.PHONY: all no-logs clean log-clean
.INTERMEDIATE: %.aux %.dvi %.ptmp %.toc %.out
.PRECIOUS: %.log 

all : $(TARGET_BASENAMES:=.pdf)
no-logs : all log-clean

%.pdf : %.dvi
	echo "========== $@ ==========="
	dvipdf $< > $@

%.dvi : %.latex %.toc
	echo "========== $@ ==========="
	latex $<
	latex $<

%.toc : %.latex %.ptmp
	echo "========== $@ ==========="
	latex $<

%.ptmp : %.latex $(SOURCE_FILES) $(FIGURES)
	echo "========== $@ ==========="
	latex $<
	touch $@

clean : log-clean
	echo "========== $@ ==========="
	rm -f $(TARGET_BASENAMES:=.pdf)
	rm -f $(TARGET_BASENAMES:=.dvi)
	rm -f $(TARGET_BASENAMES:=.out)
	rm -f $(TARGET_BASENAMES:=.ptmp)
	rm -f $(TARGET_BASENAMES:=.toc)

log-clean :
	echo "========== $@ ==========="
	rm -f $(TARGET_BASENAMES:=.log)
	rm -f $(TARGET_BASENAMES:=.aux)

