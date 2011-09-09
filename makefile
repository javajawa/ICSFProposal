TARGET_FILES = proposal.pdf
SOURCE_FILES = $(wildcard **/*.latex)
FIGURES = $(wildcard figures/*)

.DEFAULT: all
.SUFFIXES:
.PHONY: all no-logs clean log-clean
.INTERMEDIATE: %.aux %.dvi %.ptmp %.toc %.out
.PRECIOUS: %.log 

all : $(TARGET_FILES)
no-logs : all log-clean

%.pdf : %.dvi
	echo "========== $@ ==========="
	dvipdf $< > $@
	rm -f $(subst .dvi,.aux,$<)

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
	rm -f $(TARGET_FILES)
	rm -f $(subst .pdf,.aux, $(TARGET_FILES))
	rm -f $(subst .pdf,.dvi, $(TARGET_FILES))
	rm -f $(subst .pdf,.toc, $(TARGET_FILES))
	rm -f $(subst .pdf,.ptmp,$(TARGET_FILES))

log-clean :
	echo "========== $@ ==========="
	rm -f $(subst .pdf,.log,$(TARGET_FILES))
	rm -f $(subst .dvi,.aux,$(TARGET_FILES))

