#!/bin/bash
set -ev
export TZ='Asia/Shanghai'

# 先 clone 再 commit，避免直接 force commit
# git clone -b master git@github.com:sbmzhcn/resume.git


git checkout master


cd resume

# ls /usr/share/fonts/
# fc-list :lang-zh

# start create pdf
touch resume.tex
xelatex resume.tex -interaction=nonstopmode
xelatex resume.tex -interaction=nonstopmode
rm -rf *.log *.aux *.out *.fls *.fdb_latexmk *.gz

# move to build dir
mkdir build
mv resume.pdf build/
