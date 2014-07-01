
# OS detected
ifeq ($(OS),Windows_NT)
	ifneq ($(findstring .exe,$(SHELL)),)
    OS_TYPE := Windows
	else
    OS_TYPE := Cygwin
	endif
else
    OS_TYPE := $(shell uname -s)
endif

# Program Defintions
TEX    = lualatex -shell-escape -8bit 
BIBTEX = bibtex
INDEX  = makeindex -q 
RM     = $(if $(filter $(OS_TYPE),Windows),del /f /q ,rm -f )

all:class doc example

unpack:hustproposal.dtx hustproposal.ins
	@$(TEX) hustproposal.ins

%.cls %.tex %.md %.bib:hustproposal.dtx hustproposal.ins
	@$(TEX) hustproposal.ins

class:hustproposal.cls

doc:hustproposal.pdf

hustproposal.pdf:hustproposal.dtx
	@$(TEX) $(^F)
	@$(INDEX) -s gind.ist -o $(basename $(^F)).ind $(basename $(^F)).idx
	@$(TEX) $(^F)
	@$(TEX) $(^F)

example:example-zh example-en
example-zh:hustproposal-zh-example.pdf
example-en:hustproposal-en-example.pdf

hustproposal-zh-example.pdf hustproposal-en-example.pdf:%-example.pdf:%-example.tex hustproposal.cls ref-example.bib
	@$(TEX) $(<F)
	@$(BIBTEX) $(basename $(<F))
	@$(TEX) $(<F)
	@$(TEX) $(<F)

clean:
	-$(RM) *.acn *.acr *.alg *.aux *.bbl \
			*.blg *.dvi *.fdb_latexmk *.glg *.glo \
			*.gls *.idx *.ilg *.hd *.ind *.ist \
			*.lof *.log *.lot *.maf *.mtc \
			*.mtc0 *.nav *.nlo *.out *.pdfsync \
			*.pyg *.snm *.synctex.gz *.thm *.toc \
			*.vrb *.xdy *.tdo \
			*.cls *.tex *.md *.bib

reallyclean:
	-$(RM) *.acn *.acr *.alg *.aux *.bbl \
			*.blg *.dvi *.fdb_latexmk *.glg *.glo \
			*.gls *.idx *.ilg *.hd *.ind *.ist \
			*.lof *.log *.lot *.maf *.mtc \
			*.mtc0 *.nav *.nlo *.out *.pdfsync \
			*.pyg *.snm *.synctex.gz *.thm *.toc \
			*.vrb *.xdy *.tdo \
			*.cls *.tex *.md *.bib hustproposal*.pdf
checksum:FORCE
	perl adjust_checksum.pl hustproposal.dtx

.PHONY:all unpack class doc example example-zh example-en clean reallyclean FORCE
