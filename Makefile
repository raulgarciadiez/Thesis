all: bildln main.pdf

main.pdf: bildln main.tex
	pdflatex main
	bibtex main; true
	pdflatex main 
	pdflatex main 

bildln:
	cd Figures && $(MAKE) $(MFLAGS)


clean:
	rm -f *aux *bbl *log *pdf *toc *blg *out

