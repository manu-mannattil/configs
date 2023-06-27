# vim: ft=perl fdm=marker et sts=4 sw=4

# This is supposed to improve vimtex's error parsing.
STDOUT->autoflush;
STDERR->autoflush;

# By default, generate PDF output using PDFLaTeX. Possible values of $pdf_mode
# are: (1) generates a pdf version of the document using pdflatex, (2)
# generates a pdf version of the document from the ps file, by using the
# command specified by the $ps2pdf variable, (3) generates a pdf version of the
# document from the dvi file, by using the command specified by the $dvipdf
# variable, (4) use LuaTeX, and (5) use XeLaTex
$pdf_mode = 1;

# Disable PostScript output by default. If some other request is made for which
# a postscript file is needed, then $postscript_mode will be set to 1.
$postscript_mode = 0;

# The variable $dvi_mode defaults to 0, but if no explicit requests are made
# for other types of file (postscript, pdf), then $dvi_mode will be set to 1.
# In addition, if a request for a file for which a .dvi file is a prerequisite,
# then $dvi_mode will be set to 1.
$dvi_mode = 0;

# Program to run (along with additional parameters) if $pdf_mode is set to 1,
# or -pdf is passed.
$pdflatex = "pdflatex -file-line-error -interaction=nonstopmode -shell-escape -synctex=1 %O %S";

# XeLaTeX options when -xelatex is used.  Note that the "XeLaTeX rule" of
# Latexmk requires XeLaTeX to produce an .xdv file first.  This file is then
# converted to a PDF using `xdvipdfmx'.
$xelatex = "xelatex -no-pdf -recorder -file-line-error -interaction=nonstopmode -shell-escape -synctex=1 %O %S";

# Additional extensions of files to be removed when latexmk -c or -C is used.
$clean_ext = "acn bbl bcf fdb_latexmk glg loc nav pre %R-blx.bib %RNotes.bib run run.xml snm soc spl synctex.gz synctex.gz(busy) tdo tex.bak thm xdv";

# Run ctags on successful compilation.
$success_cmd = "ctags --tag-relative -R --languages=tex2,Tex,bib"
