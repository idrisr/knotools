# Check if a filename argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"

# Check if the file has a .srt extension
if [[ "$filename" != *.srt ]]; then
    echo "Error: File '$filename' is not a .srt file."
    exit 1
fi

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

instructions="Instructions: Summarize the following article."
start_tag="[START ARTICLE]"
end_tag="[END ARTICLE]"


output=$(tr -d '\r' < "$filename" | \
        sed -e '/^[[:space:]]*$/d' -e '/^[0-9]/d' | \
    uniq)

printf "%s\n\n%s\n%s\n\n%s\n" "${instructions}" "${start_tag}" "${output}" "${end_tag}"

exit 0
