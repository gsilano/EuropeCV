#!/bin/sh
# Check that the version is the same in all the files that mention it.
# Usage: sh tests/version.sh [expected-version]   (run from the repository root)
# With an argument (e.g. a git tag such as v2026.10.14), the version must
# also match it.
set -u
ver=$(sed -n 's/^\\ProvidesClass{europecv}\[[0-9/]* v\([0-9.]*\) .*/\1/p' europecv.cls)
date=$(sed -n 's/^\\ProvidesClass{europecv}\[\([0-9/]*\) .*/\1/p' europecv.cls)
status=0
fail() { echo "ERROR: $1"; status=1; }

[ -n "$ver" ] || { echo "ERROR: no version in \\ProvidesClass"; exit 1; }
echo "europecv.cls: version $ver, date $date"

[ "$(echo "$date" | tr / .)" = "$ver" ] || fail "date ($date) and version ($ver) differ in europecv.cls"
grep -q "^\\\\date{Version $ver " europecv.tex || fail "europecv.tex: \\date does not mention version $ver"
grep -q "^Version $ver " README.md || fail "README.md does not mention version $ver"
first=$(grep -m1 -E '^[0-9]{4}\.[0-9]{2}\.[0-9]{2}$' CHANGELOG.rst)
[ "$first" = "$ver" ] || fail "latest CHANGELOG.rst entry is $first, not $ver"
for f in ecv*.def; do
  grep -q "^\\\\ProvidesFile{$f}\[[0-9]\{4\}/[0-9]\{2\}/[0-9]\{2\} " "$f" || fail "$f: missing or malformed \\ProvidesFile"
done
if [ $# -gt 0 ]; then
  tag=${1#v}
  [ "$tag" = "$ver" ] || fail "tag $1 does not match version $ver"
fi
[ $status -eq 0 ] && echo "Version information is consistent."
exit $status
