set -e
set -u

ffprobe -i "$1" \
    -show_entries format=duration:format_tags=title,date,lyrics-ENG -v quiet -of default=noprint_wrappers=1:nokey=1 \
    -v quiet \
    -of default=noprint_wrappers=1:nokey=1 \
    | html2text -links
