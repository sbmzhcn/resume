#!/bin/bash
set -ev
export TZ='Asia/Shanghai'

# 先 clone 再 commit，避免直接 force commit
# git clone -b master git@github.com:sbmzhcn/resume.git
cd resume

ls /usr/share/fonts/

# start create pdf
touch resume.tex
xelatex resume.tex -interaction=nonstopmode
rm -rf *.log *.aux *.out *.fls *.fdb_latexmk *.gz

# start commit
cd ..

git add .
git commit -m "Resume updated: `date +"%Y-%m-%d %H:%M:%S"`"

#git push vps master:master --force --quiet
git push --force --quiet https://$REPO_TOKEN@github.com/sbmzhcn/resume.git master
