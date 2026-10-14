#!/bin/sh
# Check the content of the CTAN archive created by "make ctan" against
# the CTAN upload rules: a single top-level directory named after the
# package, no hidden, temporary or generated files, no executable files,
# Unix line endings in all text files, and a README.
# Usage: sh tests/ctan-files.sh   (run from the repository root, after make ctan)
set -u
dir=build/europecv
status=0
fail() { echo "ERROR: $1"; status=1; }

[ -f build/europecv.zip ] || { echo "ERROR: build/europecv.zip not found, run make ctan"; exit 1; }
top=$(unzip -Z1 build/europecv.zip | cut -d/ -f1 | sort -u)
[ "$top" = "europecv" ] || fail "the archive must contain only the europecv/ directory (found: $top)"

[ -f "$dir/README.md" ] || [ -f "$dir/README" ] || fail "README missing"
[ -f "$dir/europecv.pdf" ] || fail "documentation europecv.pdf missing"

hidden=$(find "$dir" -name '.*' ! -name . )
[ -z "$hidden" ] || fail "hidden files: $hidden"

junk=$(find "$dir" -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' \
  -o -name '*.toc' -o -name '*.bbl' -o -name '*.blg' -o -name '*.bcf' \
  -o -name '*.run.xml' -o -name '*.synctex.gz' -o -name '*.fls' \
  -o -name '*.fdb_latexmk' -o -name '*-eps-converted-to.pdf' -o -name '*~' \
  -o -name '*.bak' -o -name 'Thumbs.db' \))
[ -z "$junk" ] || fail "temporary or generated files: $junk"

exe=$(find "$dir" -type f -perm /111)
[ -z "$exe" ] || fail "executable files: $exe"

for f in $(find "$dir" -type f \( -name '*.cls' -o -name '*.def' -o -name '*.tex' \
    -o -name '*.bib' -o -name '*.md' -o -name '*.rst' -o -name '*.conf' -o -name LICENSE \)); do
  if grep -q "$(printf '\r')" "$f"; then fail "CRLF line endings in $f"; fi
done

[ $status -eq 0 ] && echo "CTAN archive looks fine: $(unzip -Z1 build/europecv.zip | grep -vc '/$') files."
exit $status
