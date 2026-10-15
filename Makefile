# Makefile for the europecv package
#
#   make doc        build the documentation (europecv.pdf)
#   make examples   build the examples
#   make templates  build the templates
#   make check      build everything and run the language smoke test
#   make ctan       create build/europecv.zip, ready for the CTAN upload
#   make ctancheck  create the CTAN archive and check it against the CTAN rules
#   make clean      remove auxiliary files
#
# The CTAN archive is created from the files committed to git
# (see the export-ignore attributes in .gitattributes): commit your
# changes before running "make ctan".

PKG      = europecv
LATEX    = pdflatex -interaction=nonstopmode -halt-on-error
EXAMPLES = minimal europass-cv bulgarian-utf8 bulgarian-koi8-r greek-utf8
TEMPLATES = cv_template_en cv_template_academic_en

.PHONY: all doc examples templates check ctan ctancheck clean

all: doc

doc:
	$(LATEX) $(PKG).tex
	$(LATEX) $(PKG).tex
	$(LATEX) $(PKG).tex

examples:
	cd examples && for f in $(EXAMPLES); do \
	  TEXINPUTS=..: $(LATEX) $$f.tex && TEXINPUTS=..: $(LATEX) $$f.tex || exit 1; \
	done

templates:
	cd templates && for f in $(TEMPLATES); do \
	  TEXINPUTS=..: $(LATEX) $$f.tex && TEXINPUTS=..: $(LATEX) $$f.tex || exit 1; \
	done
	cd templates && TEXINPUTS=..: $(LATEX) cv_template_en_biber.tex \
	  && biber --configfile europecv_biber.conf cv_template_en_biber \
	  && TEXINPUTS=..: $(LATEX) cv_template_en_biber.tex \
	  && TEXINPUTS=..: $(LATEX) cv_template_en_biber.tex

check: doc examples templates
	sh tests/languages.sh pdflatex
	sh tests/languages.sh xelatex
	sh tests/languages.sh lualatex

ctan:
	rm -rf build
	mkdir -p build
	git archive --format=tar --prefix=$(PKG)/ HEAD | tar -x -C build
	cd build && zip -q -r $(PKG).zip $(PKG)
	@echo "Created build/$(PKG).zip"

ctancheck: ctan
	sh tests/version.sh
	sh tests/ctan-files.sh

clean:
	for d in . examples templates; do \
	  (cd $$d && rm -f *.aux *.log *.out *.toc *.bbl *.blg *.bcf *.run.xml \
	    *.fls *.fdb_latexmk *.synctex.gz *-eps-converted-to.pdf); \
	done
	rm -rf build
