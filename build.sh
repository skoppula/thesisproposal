#!/bin/bash

file="proposal"
author="skoppula"
totalfile="$file-$author"

# Compile the tex file
pdflatex --shell-escape -jobname=$totalfile paper.tex
bibtex $totalfile
pdflatex --shell-escape -jobname=$totalfile paper.tex
pdflatex --shell-escape -jobname=$totalfile paper.tex

mkdir -p out
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=out/${totalfile}-with-cover.pdf figs/filled_coversheet.pdf $totalfile.pdf

if [ "$(uname)" == "Darwin" ]; then
    open ${totalfile}.pdf &
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    evince ${totalfile}.pdf &
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo 'Windows not supported!'
fi

rm *.aux *.log *.out *.bbl *.blg
