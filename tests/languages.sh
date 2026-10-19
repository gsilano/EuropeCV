#!/bin/sh
# Smoke test: compile a small CV with every language option of europecv.
# Usage: sh tests/languages.sh [engine] [class]
#   (defaults: pdflatex and europecv; the class can also be europecv2020)
# Run it from the root of the repository.
set -u
engine=${1:-pdflatex}
cls=${2:-europecv}
root=$(pwd)
work=$(mktemp -d)
status=0
for lang in english italian spanish french danish german finnish portuges \
    portuguese swedish norwegian dutch catalan polish hungarian estonian \
    icelandic lithuanian czech slovak latvian slovenian romanian maltese \
    bulgarian greek galician serbian; do
  case "$engine:$lang" in
    pdflatex:bulgarian) pre='\usepackage[T2A]{fontenc}' ;;
    pdflatex:greek)     pre='\usepackage[LGR,T1]{fontenc}\usepackage[greek,english]{babel}' ;;
    pdflatex:*)         pre='\usepackage[T1]{fontenc}' ;;
    *:greek)            pre='\usepackage[greek,english]{babel}' ;;
    *)                  pre='' ;;
  esac
  cat > "$work/$lang.tex" <<EOF
\documentclass[$lang,totpages,flagCMYK]{$cls}
$pre
\ecvname{Doe, John}
\ecvaddress{Street}
\ecvtelephone[1][2]{3}
\ecvdate{2026}
\begin{document}
\begin{europecv}
\ecvpersonalinfo
\section{Languages}
\ecvmothertongue{X}
\ecvlanguageheader{(*)}
\ecvlanguage{Y}{\ecvAOne}{\ecvATwo}{\ecvBOne}{\ecvBTwo}{\ecvCOne}
\ecvitem{2020}{Text}
\ecvlanguagefooter{(*)}
\end{europecv}
\end{document}
EOF
  if (cd "$work" && TEXINPUTS="$root:" "$engine" -interaction=nonstopmode -halt-on-error "$lang.tex" >/dev/null 2>&1); then
    echo "ok     $cls $lang"
  else
    echo "FAILED $cls $lang"; grep -m1 -A2 '^!' "$work/$lang.log"; status=1
  fi
done
rm -rf "$work"
exit $status
