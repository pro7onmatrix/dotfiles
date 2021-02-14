#!/bin/sh

draw() {
    ~/.config/lf/draw_img.sh "$@"
    exit 1
}

hash() {
    printf '%s/lf/%s' "$XDG_CACHE_HOME" \
        "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{ print $1 }')"
}

cache() {
    if [ -f "$1" ]; then
        draw "$@"
    fi
}

file="$1"
shift

if [ -n "$FIFO_UEBERZUG" ]; then
    case "$(file -Lb --mime-type -- "$file")" in
        image/*)
            orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
            if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
                preview="$(hash "$file").jpg"
                cache "$preview" "$@"
                convert -- "$file" -auto-orientation "$preview"
                draw "$preview" "$@"
            else
                draw "$file" "$@"
            fi
            ;;
        video/*)
            preview="$(hash "$file").jpg"
            cache "$preview" "$@"
            ffmpegthumbnailer -i "$file" -o "$preview" -s 0
            draw "$preview" "$@"
            ;;
        application/pdf)
            preview="$(hash "$file").jpg"
            cache "$preview" "$@"
            /usr/bin/gs -o "$preview" -sDEVICE=jpeg -dLastPage=1 "$file" >/dev/null
            draw "$preview" "$@"
            ;;
        *) bat --color=always "$file" ;;
    esac
fi

file --Lb -- "$1" | fold -s -w "$width"
exit 0
