#!/bin/bash
set -ev
export TZ='Asia/Shanghai'

# 先 clone 再 commit，避免直接 force commit
# git clone -b master git@github.com:leadscloud/resume.git


git checkout master


cd resume

# ls /usr/share/fonts/
# fc-list :lang-zh

# start create pdf
touch resume.tex
xelatex resume.tex -interaction=nonstopmode
xelatex resume.tex -interaction=nonstopmode

# create front-end pdf
touch resume-front-end.tex
xelatex resume-front-end.tex -interaction=nonstopmode
xelatex resume-front-end.tex -interaction=nonstopmode

rm -rf *.log *.aux *.out *.fls *.fdb_latexmk *.gz

# move to build dir
mkdir build
mv resume*.pdf build/

# push to coding
git clone https://git.dev.tencent.com/yzv/yzv.coding.me.git
cd yzv.coding.me
cp ../build/*.pdf resume/
git add .
git commit -m "resume.pdf updated: `date +"%Y-%m-%d %H:%M:%S"` [ci skip]"
git push --force --quiet "https://yzv:${CO_TOKEN}@git.dev.tencent.com/yzv/yzv.coding.me.git" master:master

# push to ftp
ping -c 4 $FTP_HOST
# ncftpput -R -v -u "$FTP_USER" -p "$FTP_PASS" $FTP_HOST / ../build/resume.pdf
