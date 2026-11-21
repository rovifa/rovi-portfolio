#!/usr/bin/env bash
# Build both CV PDFs from HTML using headless Edge/Chrome.
#   cv-ats.html               -> public/cv.pdf            (ATS version, linked from the website)
#   cv-photo.template.html    -> dist/cv-rovi-fauzan-akbar-photo.pdf (photo + full address, not published)
# Experience/summary content lives only in cv-ats.html; the photo version reuses it.
set -euo pipefail
cd "$(dirname "$0")"

BROWSER="/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
[ -x "$BROWSER" ] || BROWSER="/c/Program Files/Google/Chrome/Application/chrome.exe"

mkdir -p dist

# Assemble photo version: insert everything from <h2>Summary</h2> up to (not incl.) the skills block.
awk '/<h2>Summary<\/h2>/{f=1} /<div class="job skills">/{f=0} f' cv-ats.html > dist/main.part
awk 'FNR==NR{main=main $0 "\n"; next} /<!--MAIN-->/{printf "%s", main; next} {print}' \
  dist/main.part cv-photo.template.html > cv-photo.html

to_url() { echo "file:///$(cygpath -m "$(pwd)/$1")"; }

render() {
  "$BROWSER" --headless=new --disable-gpu --no-pdf-header-footer \
    --print-to-pdf="$(cygpath -w "$(pwd)/$2")" "$(to_url "$1")" 2>/dev/null
}

render cv-ats.html   dist/cv-rovi-fauzan-akbar-ats.pdf
render cv-photo.html dist/cv-rovi-fauzan-akbar-photo.pdf
cp dist/cv-rovi-fauzan-akbar-ats.pdf ../public/cv.pdf
rm -f dist/main.part
ls -la dist ../public/cv.pdf
