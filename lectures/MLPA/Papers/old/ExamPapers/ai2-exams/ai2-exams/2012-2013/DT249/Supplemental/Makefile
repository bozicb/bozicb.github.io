# Filename  : Makefile
# Purpose   : Sample Makefile for use with the 'ditpaper' TeX class, producing
#                 both exam paper and model solution from a sample paper.
# Author    : Emmet Caulfield
# Revision  : $Id: Makefile 2 2006-02-19 20:34:45Z emmet $
# Repository: $HeadURL: http://svn.netrogen.lan/tex-ditpaper/trunk/Makefile $
#
BASENAME  = paper
QUESTIONS = 
TEXINPUTS = :/usr/texbin/:.
TEXFLAGS  = --output-comment "Your comment for the PDF documents"

QFILES    = $(addsuffix .tex, $(QUESTIONS))
PDFS      = $(BASENAME)-Questions.pdf $(BASENAME)-Solutions.pdf

export TEXINPUTS


all: pdf


pdf: $(PDFS)


view: pdf
	acroread $(PDFS)


%.pdf: %.tex
# We run LaTeX twice to make sure that references are right
	pdflatex $(TEXFLAGS) $<
	pdflatex $(TEXFLAGS) $<


$(BASENAME)-Questions.tex: $(BASENAME).tex $(QFILES)
	sed 's/--SOLUTION-OPTION--/nosolution/' $< > $@


$(BASENAME)-Solutions.tex: $(BASENAME).tex $(QFILES)
	sed 's/--SOLUTION-OPTION--/solution/' $< > $@

clean:
	rm -f $(BASENAME)-{Questions,Solutions}.tex
	rm -f *.aux *.dvi *.log *~ temp.* *.bbl *.blg *.bmt *.idx *.ind
	rm -f IMG_PARAMS.db labels.pl *.toc *.mtc[0-9] *.mtc[0-9][0-9] *.mtc
	rm -f *.ilg *.mtc *.out *.lof *.lot *.exm


pristine: clean
	rm -f *.html *.pdf *.ps *.css
	rm -f IMG_PARAMS.db labels.pl


.PHONY: clean pristine view pdf all
