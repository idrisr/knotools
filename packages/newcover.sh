set -e
set -u

usage() {
    echo "$0 <file name> <image url>"
    exit 1
}

if [ "$#" != 2 ]; then
    usage
fi

if [[ ! -f "$1" ]]; then
    echo "$1 does not exit"
    exit 1
fi

if ! dims=$(dimensions "$1" | head -n1) ; then
    echo "error extracting dimensions from: $1"
    exit 1
fi

width=$(echo "$dims" | awk '{print $1}')
height=$(echo "$dims" | awk '{print $2}')
input=$(realpath "$1")
filepath=${input%.*}
filename=${filepath##*/}

cover=cover.jpg
cd "$(mktemp -d)"
if ! wget "$2" --output-document="$cover"; then
    echo "error retrieving url: $2"
    exit 1
fi

# todo: doesnt handle crop rects properly
# when there's a crop rect the cover is too large

# see linux assembly language step by step for example of pdf that this script
# does not work for

convert "$cover" -resize "${width}x${height}!" cover.pdf
pdftk cover.pdf "$input" output "$OLDPWD/$filename-new.pdf"
rm $cover
