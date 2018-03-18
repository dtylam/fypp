#!/bin/bash
# Proper header for a Bash script.

if [ $# -ne 1 ]; then
    echo $0: usage: export.sh filename
    exit 1
fi

FILE=$1
INPUT_TEX=$FILE.tex
INPUT_PS=$FILE.ps
OUTPUT_DVI=$FILE.dvi
OUTPUT_TMP=$FILE-temp.pdf
OUTPUT_PDF=$FILE.pdf
OUTPUT_EPS=$FILE.eps
OUTPUT_PNG=$FILE.png

JUNK_AUX=$FILE.aux
JUNK_LOG=$FILE.log

# Generate files

latex $INPUT_TEX
dvips -t unknown $OUTPUT_DVI
ps2pdf $INPUT_PS $OUTPUT_TMP
pdfcrop --hires $OUTPUT_TMP $OUTPUT_PDF
# pdftops -eps $OUTPUT_PDF $OUTPUT_EPS
# convert -density 300 $OUTPUT_PDF -quality 90 $OUTPUT_PNG

# Clean up
rm -rf $INPUT_PS $OUTPUT_DVI $OUTPUT_TMP $JUNK_LOG $JUNK_AUX
rm -f $FILE.pdfsync
rm -rf *~ *.tmp
rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk *.aux *.glo
rm -f *.idx *.log *.toc *.ist *.acn *.acr *.alg *.bbl *.blg *.dvi *.glg
rm -f *.gls *.ilg *.ind *.lof *.lot *.maf *.mtc *.mtc1 *.out *.synctex.gz

exit
