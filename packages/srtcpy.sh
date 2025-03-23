# Check if a filename argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"
srt_filename="${filename%%.*}.en.srt"  # Remove extension (if any) and append .srt

# Check if the .srt file exists
if [ ! -f "$srt_filename" ]; then
    echo "Error: File '$srt_filename' not found."
    exit 1
fi

instructions="Instructions: Summarize the following article."
start_tag="[START ARTICLE]"
end_tag="[END ARTICLE]"

output=$(tr -d '\r' < "$srt_filename" | \
        sed -e '/^[[:space:]]*$/d' -e '/^[0-9]/d' | \
    uniq)

printf "%s\n\n%s\n%s\n\n%s\n" "${instructions}" "${start_tag}" "${output}" "${end_tag}"

exit 0
