#!/usr/bin/env bash
set -e

[[ -z "$VIRTUAL_ENV" ]] && echo "Refusing to run outside of venv. See README.md." && exit 100

python3 -m pip install 'fonttools >= 4.41.1'

# import functions and globals
source url.sh
source helper.sh
source categories.sh

# --- execution starts here ---
mkdir -p cache/

# GoNotoCurrentRegular.ttf
create_cjk_subset
create_duployan_subset
create_japanese_kana_subset
create_korean_hangul_subset
create_math_subset
create_tibetan_subset

echo "Generating NotoSans-Regular.ttf. Current time: $(date)."
go_build NotoSans-Regular.ttf "${GoNotoCurrentRegular[@]}"

echo "Generating NotoSans-Bold.ttf. Current time: $(date)."
go_build NotoSans-Bold.ttf "${GoNotoCurrentBold[@]}"

echo "Generating NotoSans-Italic.ttf. Current time: $(date)."
go_build NotoSans-Italic.ttf "${GoNotoCurrentItalic[@]}"

echo "Generating Noto-BoldItalic.ttf. Current time: $(date)."
go_build NotoSans-BoldItalic.ttf "${GoNotoCurrentBoldItalic[@]}"
