all:
	make resume
resume:
	touch resume.tex
	xelatex resume.tex
	touch resume-front-end.tex
	xelatex resume-front-end.tex
	make clean
clean:
	rm -rf *.log *.aux *.out *.fls *.fdb_latexmk *.gz
