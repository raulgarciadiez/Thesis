SRCDIR=$(wildcard */)
PDFS = $(SRCDIR:.src/=.pdf)
TEXS = $(SRCDIR:.src/=.tex)

all: $(PDFS)

.SUFFIXES: .eps .tex .src

%.tex %.pdf: %.src/*.gp %.src/*.dat style.gp
	@echo "Making $@"
	cd $*.src && (echo 'load "../style.gp"';\
	echo 'set output "$*.tex"' ;\
	echo 'set terminal epslatex size 10cm,8cm color colortext'; \
	echo 'load "plot.gp"'; \
	echo 'set output ') | gnuplot
	ps2pdf -dEPSCrop -dAutoRotatePages=/None $*.src/$*.eps $*.pdf
	mv $*.src/$*.tex .
	rm $*.src/$*.eps
	
clean:
	rm -f $(PDFS) $(TEXS)
		
	
