#!/usr/bin/env bash
set -e

download_url() {
    local name=''
    name=$(basename "$1")
    # Do not download if file already exists
    if [[ ! -e "$name" ]]; then
        wget -nv -O "$name" "$1"
    fi
}

# Rename font metadata
edit_font_info() {
    local fontname="$1"
    local without_spaces="${fontname%%.*}"
    local with_spaces=''

    with_spaces=$(echo "$without_spaces" | sed -E 's/([a-z])([A-Z])/\1 \2/g')

    python3 ./rename_font.py "$fontname" "$with_spaces" "$without_spaces"
}

# cannot merge with 'vmtx' and 'vhea' tables.
drop_vertical_tables() {
    local fontname="$1"
    local output_font="${fontname/-/Subset-}"
    local dirname="${fontname/-*/}"

    cd cache/

    if [[ ! -e "$output_font" ]]; then
        download_url "https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/$dirname/$fontname"
        echo "Removing vertical tables from $fontname"
        "$VIRTUAL_ENV"/bin/pyftsubset --recommended-glyphs --passthrough-tables \
                      --glyphs='*' --unicodes='*' --glyph-names --layout-features='*' \
                      --drop-tables+=vhea,vmtx "$fontname" --output-file="$output_font"
    fi

    cd "$OLDPWD"
}

# create tibetan subset so that GSUB is not overflow'ed.
create_tibetan_subset() {
    local input_font=NotoSerifTibetan-Regular.ttf
    local output_font="${input_font/-/Subset-}"
    local glyphs=0
    local exclude_regex='uni0F([45].|6[^2])0F(9.|A[^D]|B[^12])|uni[[:xdigit:]]{8,12}\.[2]'

    cd cache/

    if [[ ! -e "$output_font" ]]; then
        download_url "https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSerifTibetan/$input_font"

        echo "Creating a smaller subset of Tibetan glyphs..."
        glyphs=$("$VIRTUAL_ENV"/bin/ttx -o - -q -t GlyphOrder "$input_font" \
                     | grep '<GlyphID ' | cut -f4 -d'"' \
                     | grep -Ev  "$exclude_regex" \
                )
        "$VIRTUAL_ENV"/bin/pyftsubset --recommended-glyphs --passthrough-tables \
                      --layout-features='*' --glyph-names --no-layout-closure \
                      --glyphs="${glyphs}" "$input_font" --output-file="$output_font"
    fi

    python3 ../rename_font.py "$output_font" "Noto Tibetan Subset" "NotoTibetanSubset"

    cd "$OLDPWD"
}

# Unihan IICore 2005 is a small subset of CJK (~10k codepoints).
# Recently it has been superseded by UnihanCore2020, which is double in size.
create_cjk_iicore() {
    local input_font=NotoSansCJKsc-Regular.otf
    local output_font=GoNotoCJKCore2005.otf
    local subset_codepoints=unihan_iicore.txt

    if [[ -e "$output_font" ]]; then
        echo "Not overwriting existing font $output_font."
        return
    fi

    cd cache/

    download_url "https://www.unicode.org/Public/UCD/latest/ucd/Unihan.zip"
    python3 -m zipfile -e Unihan.zip .
    grep kIICore Unihan_IRGSources.txt | cut -f1 > "$subset_codepoints"
    python3 ../get_codepoints.py NotoSans-Regular.ttf >> "$subset_codepoints"
    download_url "https://github.com/googlefonts/noto-cjk/raw/main/Sans/OTF/SimplifiedChinese/$input_font"

    cd "$OLDPWD"

    echo "Generating font $output_font. Current time: $(date)."
    "$VIRTUAL_ENV"/bin/pyftsubset cache/"$input_font" \
                  --unicodes-file=cache/"$subset_codepoints" \
                  --recommended-glyphs --passthrough-tables --glyph-names \
                  --layout-features='*' --output-file="$output_font"

    python3 ./rename_font.py "$output_font" \
                             "Go Noto CJK Core 2005" \
                             "${output_font%%.*}"
}

create_cjk_subset() {
    local input_otf=NotoSansCJKsc-Regular.otf
    local subset_otf="${input_otf/-/Subset-}"
    local subset_ttf="${subset_otf/otf/ttf}"
    local codepoints=""
    local features=""

#    codepoints+="U+2E80-2EFF,"   # CJK radicals supplement
#    codepoints+="U+2F00-2FD5,"   # Kangxi radicals
    codepoints+="U+3000-303F,"   # CJK symbols and punctuation
    codepoints+="U+3100-312F,"   # Bopomofo
    codepoints+="U+31A0-31BF,"   # Bopomofo extended
    codepoints+="U+31C0-31EF,"   # CJK strokes
    codepoints+="U+FE30-FE4F,"   # CJK compatibility forms, used with vertical writing

    # Prepared by first subsetting with --layout-features='*' and then
    # dropping 'vert', 'vhal', 'vkrn', 'vpal', 'vrt2', 'hist'
    features+="aalt,ccmp,dlig,fwid,halt,hwid,kern,liga,locl,palt,pwid"

    if [[ -e "cache/$subset_ttf" ]]; then
        echo "Not overwriting existing font $subset_ttf."
        return
    fi

    cd cache/

    download_url "https://github.com/googlefonts/noto-cjk/raw/main/Sans/OTF/SimplifiedChinese/$input_otf"

    echo "Generating CJK font $subset_ttf..."

    download_url "https://www.unicode.org/Public/UCD/latest/ucd/Unihan.zip"
    python3 -m zipfile -e Unihan.zip .
    grep kIICore Unihan_IRGSources.txt | cut -f1 > unihan_iicore.txt

    # Choose U+4e00 to U+6000 to avoid cmap format 4 subtable overflow
    # (reduce number of segments)
    for code in $(seq 0x4e00 0x6000); do
        printf "U+%x\n" "$code"
    done > unihan_range.txt

    # Combine it with IICore codepoints
    cat unihan_iicore.txt unihan_range.txt | sort | uniq > Unihan_codepoints.txt

    # Passthrough tables which cannot be subset
    "$VIRTUAL_ENV"/bin/pyftsubset --drop-tables=vhea,vmtx --glyph-names \
                  --recommended-glyphs --passthrough-tables --layout-features="$features" \
                  --unicodes-file=Unihan_codepoints.txt --unicodes="$codepoints" \
                  --output-file="$subset_otf" "$input_otf"

    # convert otf to ttf
    download_url https://github.com/fonttools/fonttools/raw/main/Snippets/otf2ttf.py
    python3 ./otf2ttf.py --post-format 2 -o "$subset_ttf" "$subset_otf"
    python3 ../rename_font.py "$subset_ttf" "Noto Sans CJKsc Subset" "NotoSansCJKscSubset"

    cd "$OLDPWD"
}

create_korean_hangul_subset() {
    local input_otf=NotoSansCJKkr-Regular.otf
    local subset_otf="${input_otf/-/Subset-}"
    local subset_ttf="${subset_otf/otf/ttf}"
    local codepoints=""

    if [[ -e "cache/$subset_ttf" ]]; then
        echo "Not overwriting existing font $subset_ttf."
        return
    fi

    codepoints+="U+1100-11FF," # Hangul jamo
    codepoints+="U+3130-318F," # Hangul compatibility jamo

    cd cache/

    download_url "https://github.com/googlefonts/noto-cjk/raw/main/Sans/OTF/Korean/$input_otf"

    echo "Generating Korean font $subset_ttf..."
    "$VIRTUAL_ENV"/bin/pyftsubset --drop-tables=vhea,vmtx --glyph-names \
                  --recommended-glyphs --passthrough-tables --layout-features-="vert" \
                  --unicodes="$codepoints" \
                  --output-file="$subset_otf" "$input_otf"

    # convert otf to ttf
    download_url https://github.com/fonttools/fonttools/raw/main/Snippets/otf2ttf.py
    python3 ./otf2ttf.py --post-format 2 -o "$subset_ttf" "$subset_otf"

    python3 ../rename_font.py "$subset_ttf" "Noto Sans CJKkr Subset" "NotoSansCJKkrSubset"

    cd "$OLDPWD"
}

create_japanese_kana_subset() {
    local input_otf=NotoSansCJKjp-Regular.otf
    local subset_otf="${input_otf/-/Subset-}"
    local subset_ttf="${subset_otf/otf/ttf}"
    local codepoints=""
    local features=""

    if [[ -e "cache/$subset_ttf" ]]; then
        echo "Not overwriting existing font $subset_ttf."
        return
    fi

    codepoints+="U+3040-309F,"   # Hiragana
    codepoints+="U+30A0-30FF,"   # Katakana
    codepoints+="U+31F0-31FF,"   # Katakana phonetic extentsions
    codepoints+="U+3200-32FF,"   # Enclosed CJK letters and months
    codepoints+="U+3300-33FF,"   # CJK Compatibility
    codepoints+="U+FF00-FFEF,"   # Halfwidth and fullwidth forms
    codepoints+="U+1F200-1F2FF," # Enclosed ideographic supplement

    # Prepared by first subsetting with --layout-features='*' and then
    # dropping 'vert', 'vhal', 'vkrn', 'vpal', 'vrt2'
    features+="aalt,ccmp,dlig,fwid,halt,hwid,kern,liga,locl,palt,pwid"

    cd cache/

    download_url "https://github.com/googlefonts/noto-cjk/raw/main/Sans/OTF/Japanese/$input_otf"

    echo "Generating Japanese font $subset_ttf..."
    "$VIRTUAL_ENV"/bin/pyftsubset --drop-tables=vhea,vmtx --glyph-names \
                  --recommended-glyphs --passthrough-tables --layout-features="$features" \
                  --unicodes="$codepoints" --output-file="$subset_otf" "$input_otf"

    # convert otf to ttf
    download_url https://github.com/fonttools/fonttools/raw/main/Snippets/otf2ttf.py
    python3 ./otf2ttf.py --post-format 2 -o "$subset_ttf" "$subset_otf"

    python3 ../rename_font.py "$subset_ttf" "Noto Sans CJKjp Subset" "NotoSansCJKjpSubset"

    cd "$OLDPWD"
}