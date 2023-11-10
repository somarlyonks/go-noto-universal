#!/usr/bin/env bash
set -e

# export these variables
declare -x GoNotoCurrentRegular
declare -x GoNotoCurrentBold

GoNotoCurrentRegular=(
    # It's recommended to put NotoSans-Regular.ttf as the first element in the
    # list to maximize the amount of meta data retained in the final merged font.
    # ------- South Asia ---------
    "NotoSans-Regular.ttf"
    # "NotoSansArabic-Regular.ttf"
    "NotoSansBengali-Regular.ttf"
    "NotoSansGunjalaGondi-Regular.ttf"
    "NotoSansGurmukhi-Regular.ttf"
    "NotoSansKannada-Regular.ttf"
    "NotoSansMalayalam-Regular.ttf"
    "NotoSansOlChiki-Regular.ttf"
    "NotoSansOriya-Regular.ttf"
    "NotoSansTelugu-Regular.ttf"
    "NotoSansThaana-Regular.ttf"
    "NotoSerifTibetanSubset-Regular.ttf"
    # SE Asia
    "NotoSansCham-Regular.ttf"
    "NotoSansJavanese-Regular.ttf"
    "NotoSansKayahLi-Regular.ttf"
    "NotoSansKhmer-Regular.ttf"
    "NotoSansMyanmar-Regular.ttf"
    "NotoSansNewTaiLue-Regular.ttf"
    "NotoSansThai-Regular.ttf"
    "NotoSansArmenian-Regular.ttf"
    "NotoSansCherokee-Regular.ttf"
    "NotoSansGeorgian-Regular.ttf"
    # 'GoNotoAfricaMiddleEast.ttf': [
    "NotoSansHebrew-Regular.ttf"
    "NotoSansSyriac-Regular.ttf"
    "NotoSansEthiopic-Regular.ttf"
    "NotoSansCJKjpSubset-Regular.ttf"
    "NotoSansCJKkrSubset-Regular.ttf"
    "NotoSansCJKscSubset-Regular.ttf"
    # Common for all scripts
    "NotoSansSymbols-Regular.ttf"
    "NotoSansSymbols2-Regular.ttf"
    "NotoSansMathSubset-Regular.ttf"
    "NotoMusic-Regular.ttf"
)

GoNotoCurrentBold=(
    # It's recommended to put NotoSans-Bold.ttf as the first element in the
    # list to maximize the amount of meta data retained in the final merged font.
    # ------- South Asia ---------
    "NotoSans-Bold.ttf"
    "NotoSansArabic-SemiBold.ttf"
    "NotoSansBengali-Bold.ttf"
    "NotoSansGunjalaGondi-Bold.ttf"
    "NotoSansGurmukhi-Bold.ttf"
    "NotoSansKannada-Bold.ttf"
    "NotoSansMalayalam-Bold.ttf"
    "NotoSansOlChiki-Bold.ttf"
    "NotoSansOriya-Bold.ttf"
    "NotoSansTelugu-Bold.ttf"
    "NotoSansThaana-Bold.ttf"
    "NotoSerifTibetanSubset-Bold.ttf"
    # SE Asia
    "NotoSansCham-Bold.ttf"
    "NotoSansJavanese-Bold.ttf"
    "NotoSansKayahLi-Bold.ttf"
    "NotoSansKhmer-Bold.ttf"
    "NotoSansMyanmar-Bold.ttf"
    "NotoSansNewTaiLue-Bold.ttf"
    "NotoSansThai-Bold.ttf"
    "NotoSansArmenian-Bold.ttf"
    "NotoSansCherokee-Bold.ttf"
    "NotoSansGeorgian-Bold.ttf"
    # 'GoNotoAfricaMiddleEast.ttf': [
    "NotoSansHebrew-Bold.ttf"
    "NotoSansSyriac-Black.ttf"
    "NotoSansEthiopic-Bold.ttf"
    "NotoSansCJKjpSubset-Bold.ttf"
    "NotoSansCJKkrSubset-Bold.ttf"
    "NotoSansCJKscSubset-Bold.ttf"
    # Common for all scripts
    "NotoSansSymbols-Bold.ttf"
    "NotoSansSymbols2-Regular.ttf" # No bold
    "NotoSansMathSubset-Regular.ttf" # No bold
    "NotoMusic-Regular.ttf" # No bold
)

GoNotoCurrentItalic=(
    # It's recommended to put NotoSans-Regular.ttf as the first element in the
    # list to maximize the amount of meta data retained in the final merged font.
    # ------- South Asia ---------
    "NotoSans-Italic.ttf"
    # "NotoSansArabic-Regular.ttf"
    "NotoSansBengali-Regular.ttf" # no italic
    "NotoSansGunjalaGondi-Regular.ttf" # no italic
    "NotoSansGurmukhi-Regular.ttf" # no italic
    "NotoSansKannada-Regular.ttf" # no italic
    "NotoSansMalayalam-Regular.ttf" # no italic
    "NotoSansOlChiki-Regular.ttf" # no italic
    "NotoSansOriya-Regular.ttf" # no italic
    "NotoSansTelugu-Regular.ttf" # no italic
    "NotoSansThaana-Regular.ttf" # no italic
    "NotoSerifTibetanSubset-Regular.ttf" # no italic
    # SE Asia
    "NotoSansCham-Regular.ttf" # no italic
    "NotoSansJavanese-Regular.ttf" # no italic
    "NotoSansKayahLi-Regular.ttf" # no italic
    "NotoSansKhmer-Regular.ttf" # no italic
    "NotoSansMyanmar-Regular.ttf" # no italic
    "NotoSansNewTaiLue-Regular.ttf" # no italic
    "NotoSansThai-Regular.ttf" # no italic
    "NotoSansArmenian-Regular.ttf" # no italic
    "NotoSansCherokee-Regular.ttf" # no italic
    "NotoSansGeorgian-Regular.ttf" # no italic
    # 'GoNotoAfricaMiddleEast.ttf': [
    "NotoSansHebrew-Regular.ttf" # no italic
    "NotoSansSyriac-Regular.ttf" # no italic
    "NotoSansEthiopic-Regular.ttf" # no italic
    "NotoSansCJKjpSubset-Regular.ttf" # no italic
    "NotoSansCJKkrSubset-Regular.ttf" # no italic
    "NotoSansCJKscSubset-Regular.ttf" # no italic
    # Common for all scripts
    "NotoSansSymbols-Regular.ttf" # no italic
    "NotoSansSymbols2-Regular.ttf" # no italic
    "NotoSansMathSubset-Regular.ttf" # no italic
    "NotoMusic-Regular.ttf" # no italic
)

GoNotoCurrentBoldItalic=(
    # It's recommended to put NotoSans-Regular.ttf as the first element in the
    # list to maximize the amount of meta data retained in the final merged font.
    # ------- South Asia ---------
    "NotoSans-BoldItalic.ttf"
    # "NotoSansArabic-Regular.ttf"
    "NotoSansBengali-Bold.ttf" # no italic
    "NotoSansGunjalaGondi-Bold.ttf" # no italic
    "NotoSansGurmukhi-Bold.ttf" # no italic
    "NotoSansKannada-Bold.ttf" # no italic
    "NotoSansMalayalam-Bold.ttf" # no italic
    "NotoSansOlChiki-Bold.ttf" # no italic
    "NotoSansOriya-Bold.ttf" # no italic
    "NotoSansTelugu-Bold.ttf" # no italic
    "NotoSansThaana-Bold.ttf" # no italic
    "NotoSerifTibetanSubset-Bold.ttf" # no italic
    # SE Asia
    "NotoSansCham-Bold.ttf" # no italic
    "NotoSansJavanese-Bold.ttf" # no italic
    "NotoSansKayahLi-Bold.ttf" # no italic
    "NotoSansKhmer-Bold.ttf" # no italic
    "NotoSansMyanmar-Bold.ttf" # no italic
    "NotoSansNewTaiLue-Bold.ttf" # no italic
    "NotoSansThai-Bold.ttf" # no italic
    "NotoSansArmenian-Bold.ttf" # no italic
    "NotoSansCherokee-Bold.ttf" # no italic
    "NotoSansGeorgian-Bold.ttf" # no italic
    # 'GoNotoAfricaMiddleEast.ttf': [
    "NotoSansHebrew-Bold.ttf" # no italic
    "NotoSansSyriac-Black.ttf" # no italic
    "NotoSansEthiopic-Bold.ttf" # no italic
    "NotoSansCJKjpSubset-Bold.ttf" # no italic
    "NotoSansCJKkrSubset-Bold.ttf" # no italic
    "NotoSansCJKscSubset-Bold.ttf" # no italic
    # Common for all scripts
    "NotoSansSymbols-Bold.ttf" # no italic
    "NotoSansSymbols2-Regular.ttf" # No bold no italic
    "NotoSansMathSubset-Regular.ttf" # No bold no italic
    "NotoMusic-Regular.ttf" # No bold no italic
)
