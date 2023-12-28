set -e
set -u

usage() {
  echo "usage: $0 <my-file.md>"
  exit 1
}

if [[ "$#" != 1 ]]; then
  usage
fi

input=$(realpath "$1")
dims=$(pdftk "$input" dump_data_utf8 | rg --text pagemediacroprect | sort -u | head -n1)
width=$(echo "$dims" | awk '{print $4}')
height=$(echo "$dims" | awk '{print $5}')

echo "${width%.*} ${height%.*}"
