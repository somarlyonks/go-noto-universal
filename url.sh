#!/opt/homebrew/bin/bash
set -eu

# URL:s taken from https://notofonts.github.io/

# Associative array (key-value pair)
# Sorted alphabetically as per keys

# Those fonts NOT directly under notofonts.github.io/fonts/
# are not yet migrated fully (apparently) and hence development build URLs are used below

# Problematic/unavailable URLs are marked TODO
declare -A font_urls=(
    ["NotoSans-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSans/hinted/ttf/NotoSans-Regular.ttf
    ["NotoSans-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSans/hinted/ttf/NotoSans-Bold.ttf
    ["NotoSans-Italic.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSans/hinted/ttf/NotoSans-Italic.ttf
    ["NotoSans-BoldItalic.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSans/hinted/ttf/NotoSans-BoldItalic.ttf

    ["NotoSansArabic-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansArabic/hinted/ttf/NotoSansArabic-Regular.ttf
    ["NotoSansArabic-SemiBold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansArabic/hinted/ttf/NotoSansArabic-SemiBold.ttf

    ["NotoSansBengali-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansBengali/hinted/ttf/NotoSansBengali-Regular.ttf
    ["NotoSansBengali-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansBengali/hinted/ttf/NotoSansBengali-Bold.ttf

    ["NotoSansGunjalaGondi-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansGunjalaGondi/hinted/ttf/NotoSansGunjalaGondi-Regular.ttf
    ["NotoSansGunjalaGondi-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansGunjalaGondi/hinted/ttf/NotoSansGunjalaGondi-Bold.ttf

    ["NotoSansGurmukhi-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansGurmukhi/hinted/ttf/NotoSansGurmukhi-Regular.ttf
    ["NotoSansGurmukhi-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansGurmukhi/hinted/ttf/NotoSansGurmukhi-Bold.ttf

    ["NotoSansKannada-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansKannada/hinted/ttf/NotoSansKannada-Regular.ttf
    ["NotoSansKannada-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansKannada/hinted/ttf/NotoSansKannada-Bold.ttf

    ["NotoSansMalayalam-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansMalayalam/hinted/ttf/NotoSansMalayalam-Regular.ttf
    ["NotoSansMalayalam-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansMalayalam/hinted/ttf/NotoSansMalayalam-Bold.ttf

    ["NotoSansOlChiki-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansOlChiki/hinted/ttf/NotoSansOlChiki-Regular.ttf
    ["NotoSansOlChiki-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansOlChiki/hinted/ttf/NotoSansOlChiki-Bold.ttf

    ["NotoSansOriya-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansOriya/hinted/ttf/NotoSansOriya-Regular.ttf
    ["NotoSansOriya-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansOriya/hinted/ttf/NotoSansOriya-Bold.ttf

    ["NotoSansTelugu-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansTelugu/hinted/ttf/NotoSansTelugu-Regular.ttf
    ["NotoSansTelugu-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansTelugu/hinted/ttf/NotoSansTelugu-Bold.ttf

    ["NotoSansThaana-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansThaana/hinted/ttf/NotoSansThaana-Regular.ttf
    ["NotoSansThaana-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansThaana/hinted/ttf/NotoSansThaana-Bold.ttf

    ["NotoSerifTibetan-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifTibetan/hinted/ttf/NotoSerifTibetan-Regular.ttf
    ["NotoSerifTibetan-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifTibetan/hinted/ttf/NotoSerifTibetan-Bold.ttf

    ["NotoSansCham-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansCham/hinted/ttf/NotoSansCham-Regular.ttf
    ["NotoSansCham-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansCham/hinted/ttf/NotoSansCham-Bold.ttf

    ["NotoSansJavanese-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansJavanese/hinted/ttf/NotoSansJavanese-Regular.ttf
    ["NotoSansJavanese-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansJavanese/hinted/ttf/NotoSansJavanese-Bold.ttf

    ["NotoSansKayahLi-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansKayahLi/hinted/ttf/NotoSansKayahLi-Regular.ttf
    ["NotoSansKayahLi-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansKayahLi/hinted/ttf/NotoSansKayahLi-Bold.ttf

    ["NotoSansKhmer-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansKhmer/hinted/ttf/NotoSansKhmer-Regular.ttf
    ["NotoSansKhmer-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansKhmer/hinted/ttf/NotoSansKhmer-Bold.ttf

    ["NotoSansMyanmar-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansMyanmar/hinted/ttf/NotoSansMyanmar-Regular.ttf
    ["NotoSansMyanmar-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansMyanmar/hinted/ttf/NotoSansMyanmar-Bold.ttf

    ["NotoSansNewTaiLue-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansNewTaiLue/hinted/ttf/NotoSansNewTaiLue-Regular.ttf
    ["NotoSansNewTaiLue-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansNewTaiLue/hinted/ttf/NotoSansNewTaiLue-Bold.ttf

    ["NotoSansThai-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansThai/hinted/ttf/NotoSansThai-Regular.ttf
    ["NotoSansThai-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansThai/hinted/ttf/NotoSansThai-Bold.ttf

    ["NotoSansArmenian-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansArmenian/hinted/ttf/NotoSansArmenian-Regular.ttf
    ["NotoSansArmenian-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansArmenian/hinted/ttf/NotoSansArmenian-Bold.ttf

    ["NotoSansCherokee-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansCherokee/hinted/ttf/NotoSansCherokee-Regular.ttf
    ["NotoSansCherokee-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansCherokee/hinted/ttf/NotoSansCherokee-Bold.ttf

    ["NotoSansGeorgian-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansGeorgian/hinted/ttf/NotoSansGeorgian-Regular.ttf
    ["NotoSansGeorgian-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansGeorgian/hinted/ttf/NotoSansGeorgian-Bold.ttf

    ["NotoSansHebrew-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansHebrew/hinted/ttf/NotoSansHebrew-Regular.ttf
    ["NotoSansHebrew-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansHebrew/hinted/ttf/NotoSansHebrew-Bold.ttf

    ["NotoSansSyriac-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansSyriac/hinted/ttf/NotoSansSyriac-Regular.ttf
    ["NotoSansSyriac-Black.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansSyriac/hinted/ttf/NotoSansSyriac-Black.ttf

    ["NotoSansEthiopic-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansEthiopic/hinted/ttf/NotoSansEthiopic-Regular.ttf
    ["NotoSansEthiopic-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansEthiopic/hinted/ttf/NotoSansEthiopic-Bold.ttf

    ["NotoMusic-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoMusic/hinted/ttf/NotoMusic-Regular.ttf
    ["NotoSansMath-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansMath/hinted/ttf/NotoSansMath-Regular.ttf
    ["NotoSansSymbols-Bold.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansSymbols/hinted/ttf/NotoSansSymbols-Bold.ttf
    ["NotoSansSymbols-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansSymbols/hinted/ttf/NotoSansSymbols-Regular.ttf
    ["NotoSansSymbols2-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSansSymbols2/hinted/ttf/NotoSansSymbols2-Regular.ttf

    ["NotoSansDuployan-Regular.ttf"]=https://notofonts.github.io/duployan/fonts/NotoSansDuployan/unhinted/ttf/NotoSansDuployan-Regular.ttf # TODO: Cannot merge 'CFF ' table

    ["NotoSerif-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerif/hinted/ttf/NotoSerif-Regular.ttf
    ["NotoSerifAhom-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifAhom/hinted/ttf/NotoSerifAhom-Regular.ttf
    ["NotoSerifArmenian-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifArmenian/hinted/ttf/NotoSerifArmenian-Regular.ttf
    ["NotoSerifBalinese-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifBalinese/hinted/ttf/NotoSerifBalinese-Regular.ttf
    ["NotoSerifBengali-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifBengali/hinted/ttf/NotoSerifBengali-Regular.ttf
    ["NotoSerifDevanagari-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifDevanagari/hinted/ttf/NotoSerifDevanagari-Regular.ttf
    ["NotoSerifDivesAkuru-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifDivesAkuru/hinted/ttf/NotoSerifDivesAkuru-Regular.ttf
    ["NotoSerifDogra-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifDogra/hinted/ttf/NotoSerifDogra-Regular.ttf
    ["NotoSerifEthiopic-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifEthiopic/hinted/ttf/NotoSerifEthiopic-Regular.ttf
    ["NotoSerifGeorgian-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifGeorgian/hinted/ttf/NotoSerifGeorgian-Regular.ttf
    ["NotoSerifGrantha-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifGrantha/hinted/ttf/NotoSerifGrantha-Regular.ttf
    ["NotoSerifGujarati-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifGujarati/hinted/ttf/NotoSerifGujarati-Regular.ttf
    ["NotoSerifGurmukhi-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifGurmukhi/hinted/ttf/NotoSerifGurmukhi-Regular.ttf
    ["NotoSerifHebrew-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifHebrew/hinted/ttf/NotoSerifHebrew-Regular.ttf
    ["NotoSerifKannada-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifKannada/hinted/ttf/NotoSerifKannada-Regular.ttf
    ["NotoSerifKhitanSmallScript-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifKhitanSmallScript/hinted/ttf/NotoSerifKhitanSmallScript-Regular.ttf
    ["NotoSerifKhmer-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifKhmer/hinted/ttf/NotoSerifKhmer-Regular.ttf
    ["NotoSerifKhojki-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifKhojki/hinted/ttf/NotoSerifKhojki-Regular.ttf
    ["NotoSerifLao-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifLao/hinted/ttf/NotoSerifLao-Regular.ttf
    ["NotoSerifMakasar-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifMakasar/hinted/ttf/NotoSerifMakasar-Regular.ttf
    ["NotoSerifMalayalam-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifMalayalam/hinted/ttf/NotoSerifMalayalam-Regular.ttf
    ["NotoSerifMyanmar-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifMyanmar/hinted/ttf/NotoSerifMyanmar-Regular.ttf
    ["NotoSerifNyiakengPuachueHmong-Regular.ttf"]=https://github.com/notofonts/noto-fonts/raw/main/hinted/ttf/NotoSerifNyiakengPuachueHmong/NotoSerifNyiakengPuachueHmong-Regular.ttf # TODO
    ["NotoSerifOldUyghur-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifOldUyghur/hinted/ttf/NotoSerifOldUyghur-Regular.ttf
    ["NotoSerifOriya-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifOriya/hinted/ttf/NotoSerifOriya-Regular.ttf
    ["NotoSerifOttomanSiyaq-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifOttomanSiyaq/hinted/ttf/NotoSerifOttomanSiyaq-Regular.ttf
    ["NotoSerifSinhala-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifSinhala/hinted/ttf/NotoSerifSinhala-Regular.ttf
    ["NotoSerifTamil-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifTamil/hinted/ttf/NotoSerifTamil-Regular.ttf
    ["NotoSerifTangut-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifTangut/hinted/ttf/NotoSerifTangut-Regular.ttf
    ["NotoSerifTelugu-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifTelugu/hinted/ttf/NotoSerifTelugu-Regular.ttf
    ["NotoSerifVithkuqi-Regular.ttf"]=https://cdn.jsdelivr.net/gh/notofonts/notofonts.github.io/fonts/NotoSerifVithkuqi/hinted/ttf/NotoSerifVithkuqi-Regular.ttf
)

# for font in "${font_urls[@]}"; do
#   if ! wget --spider "$font" 2>/dev/null; then
#     echo "File does not exist: $font"
#  fi
# done
