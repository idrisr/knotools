# Check if a filename argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Process the file
tr -d '\r' < "$filename" | \
    sed -e '/^[[:space:]]*$/d' -e '/^[0-9]/d' | \
    uniq | \
    xclip -selection clipboard

echo "Processed file '$filename' and copied output to clipboard."

exit 0
