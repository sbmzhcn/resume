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

# push to coding
git clone https://git.dev.tencent.com/yzv/yzv.coding.me.git
cd yzv.coding.me
cp ../build/resume.pdf resume/
git add .
git commit -m "resume.pdf updated: `date +"%Y-%m-%d %H:%M:%S"` [ci skip]"
git push --force --quiet "https://yzv:${CO_TOKEN}@git.dev.tencent.com/yzv/yzv.coding.me.git" master:master

# push to ftp
ncftpput -R -v -u ${FTP_USERNAME} -p ${FTP_PASSWORD} ${FTP_SERVER} ../build/resume.pdf /