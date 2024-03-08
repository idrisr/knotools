{ writeShellApplication, pdftk, ripgrep, gnused, coreutils }:
writeShellApplication {
  runtimeInputs = [ pdftk ripgrep gnused ];
  name = "pdftc";

  text = ''
    set -e
    set -u

    usage() {
        echo "$0 <pdf file>"
        exit 1
    }

    if [ "$#" != 1 ]; then
        usage
    fi

    if [[ ! -f "$1" ]]; then
        echo "$1 does not exit"
        exit 1
    fi

    "${pdftk}/bin/pdftk" "$1" dump_data_utf8 |\
    "${ripgrep}/bin/rg" --text bookmark'(title|level)'  |\
    ${gnused}/bin/sed '$!N;s/^\([^\n]*\)\n\([^\n]*\)$/\2 \1/'|\
    ${gnused}/bin/sed -r -e 's/BookmarkLevel: //'            \
    -e 's/BookmarkTitle: //'                                 \
    -e 's/^7 /\t\t\t\t\t\t\t/'                               \
    -e 's/^6 /\t\t\t\t\t\t/'                                 \
    -e 's/^5 /\t\t\t\t\t/'                                   \
    -e 's/^4 /\t\t\t\t/'                                     \
    -e 's/^3 /\t\t\t/'                                       \
    -e 's/^2 /\t\t/'                                         \
    -e 's/^1 /\t/'                                           \
    -e 's/^\s+([0-9]+\.){7}[0-9]+\s/\t\t\t\t\t\t\t\t/'       \
    -e 's/^\s+([0-9]+\.){6}[0-9]+\s/\t\t\t\t\t\t\t/'         \
    -e 's/^\s+([0-9]+\.){5}[0-9]+\s/\t\t\t\t\t\t/'           \
    -e 's/^\s+([0-9]+\.){4}[0-9]+\s/\t\t\t\t\t/'             \
    -e 's/^\s+([0-9]+\.){3}[0-9]+\s/\t\t\t\t/'               \
    -e 's/^\s+([0-9]+\.){2}[0-9]+\s/\t\t\t/'                 \
    -e 's/^\s+([0-9]+\.){1}[0-9]+\s/\t\t/'                   \
    -e 's/\t/    /g'                                        |\
    ${coreutils}/bin/tr '[:upper:]' '[:lower:]'
  '';
}
