.PHONY: clean all

PACKAGE=tlp
OUTDIR=out

# the -shell-escape option is not necessary for TeXLive 2024+,
# but it is required for all other TeX distributions
LATEXMK=latexmk -synctex=1	\
				-interaction=noninteractive -halt-on-error \
                -file-line-error \
                -lualatex \
				-output-directory=$(OUTDIR) -cd

all: $(PACKAGE).pdf $(PACKAGE).sty

%.pdf: %.dtx %.sty
	$(LATEXMK) $*.dtx
	cp $(OUTDIR)/$*.pdf .

%.sty: %.dtx %.ins
	mkdir -p $(OUTDIR)
	lualatex --output-directory=$(OUTDIR) $*.ins
	cp $(OUTDIR)/$*.sty .

clean:
	rm -rf $(OUTDIR)
	rm -f $(PACKAGE).sty $(PACKAGE).pdf