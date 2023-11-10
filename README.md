# Go Noto Universal

## Why this

https://github.com/notofonts/noto-fonts/issues/13

Noto Fonts go universal! Did you ever want "one font for all languages"? Download pan-Unicode, [Noto
Fonts](https://github.com/googlefonts/noto-fonts) merged according to the time of usage (current,
ancient) or geographical region (Africa-MiddleEast, Europe-Americas, South Asia, SE Asia).

See [caveats](#caveats) too.

## Build

If you want to _build_ the fonts yourself, create a virtual environment (venv) and run the script
you want:

```bash
python3 -m venv venv_fonty
source venv_fonty/bin/activate
./temporal_fonts.sh  # generates GoNotoAncient.ttf and GoNotoCurrent.ttf
./regional_fonts.sh  # generates GoNoto[AfricaMiddleEast|EuropeAmericas|...].ttf
deactivate
```

Font generation can take 15 to 30 min, depending on your computer's capabilities.

Each script is designed to be reentrant, so you can run it multiple times without altering the
working state of the repository or downloading stuff again and again.

Latest CI status:

[![Regional fonts](https://github.com/satbyy/go-noto-universal/actions/workflows/regional_fonts.yml/badge.svg)](https://github.com/satbyy/go-noto-universal/actions/workflows/regional_fonts.yml)

[![Temporal fonts](https://github.com/satbyy/go-noto-universal/actions/workflows/temporal_fonts.yml/badge.svg)](https://github.com/satbyy/go-noto-universal/actions/workflows/temporal_fonts.yml)

## Dependencies

[`fonttools`](https://github.com/fonttools/fonttools/) is automatically fetched and used. The main
programs we use are `pyftmerge`, `pyftsubset` and `ttx`.

## Coverage

### Temporal Fonts

Temporal, i.e., time-based fonts are:

- **Go Noto Kurrent** -- combines 80+ Noto Fonts of scripts which are in current, daily usage. It is
  a superset of all the "[Regional Fonts](#regional-fonts)" (see below) excluding historical or
  specialty fonts. It includes support for Chinese, Japanese and Korean (CJK) too, using the [Unihan
  IICore][1] subset.
- **Go Noto Ancient** -- combines 70+ Noto Fonts of ancient, historical or liturgical scripts which
  are not used widely today. This font is probably useful for research or scholarly purposes or
  language enthusiasts. This font does not support any CJK.

Each of these fonts includes Noto Sans (Regular), Noto Sans Symbols, Noto Sans Symbols 2, Noto Sans
Math and Noto Music so that notations, symbols and emoji are not missed out.

Serif variants of these are also included but their Unicode coverage is not as good as Sans Serif
(lack of upstream Noto Serif fonts).

The exact fonts which are combined are too long to list here but can be seen from the source code.

### Go Noto CJK Core

[Unihan IICore][1] is a minimal, region-agnostic subset of Han/CJK specified in 2005 for
memory-constrained systems. It standardizes about 9800 codepoints, covering basic use cases of
Chinese (Traditional, Simplified), Japanese and Korean. Recently [Unihan Core 2020][3] superseded
and expanded the minimal subset to about 20000 codepoints. Go Noto CJK Core includes a superset of
codepoints from both of these subsets.

The GoNotoCJKCore.ttf includes "locl" layout feature, so it can display Japanese or Korean glyphs
just by switching the language in your editor/word processor/web browser etc. Hiragana, Katakana and
Hangul are included.

Why use this instead of the upstream [Noto CJK][2] Fonts? Because our font also contains Noto Sans
Math, Noto Music, Noto Sans Symbols, Noto Sans Symbols 2, plus everything in Noto Sans (Regular) --
so you can have emojis, mathematical notation, musical symbols and Latin-Greek-Cyrillic in a single
font. But all the upstream Noto CJK Fonts have maxed out 65K glyphs, so they don't have space
anymore for glyphs additions.

The only limitation is that Go Noto CJK Core does not support vertical text writing.

## Font Statistics

Font statistics are collected in tsv format (tab separated value) by the CI pipeline in every run
and can be downloaded in build Artifacts.

Statistics below correspond to release v5.1.

| Go Noto Font               | Unicode blocks | Characters | Glyphs |
|----------------------------|---------------:|-----------:|-------:|
| GoNotoCurrent.ttf          |            197 |      32804 |  61207 |
| GoNotoAncient.ttf          |            178 |      24556 |  32971 |
| GoNotoEuropeAmericas.ttf   |            120 |      13391 |  53393 |
| GoNotoAfricaMiddleEast.ttf |            128 |      16055 |  20429 |
| GoNotoSouthAsia.ttf        |            119 |      11632 |  21184 |
| GoNotoAsiaHistorical.ttf   |            124 |      11100 |  18457 |
| GoNotoSouthEastAsia.ttf    |            112 |      10813 |  15044 |
| GoNotoEastAsia.ttf         |            109 |      18710 |  24525 |
| GoNotoCJKCore.ttf          |            107 |      41132 |  61658 |

Note that each of the above include statistics of:

| Upstream font       | Unicode blocks | Characters | Glyphs |
|---------------------|---------------:|-----------:|-------:|
| Noto Sans           |             37 |       2840 |   3748 |
| Noto Sans Math      |             22 |       2472 |   2655 |
| Noto Music          |              7 |        561 |    581 |
| Noto Sans Symbols   |             15 |        840 |   1218 |
| Noto Sans Symbols 2 |             37 |       2655 |   2674 |
| Total               |            111 |       9368 |  10876 |

## Caveats

1. You might have to increase line spacing or line margins in your application to avoid some
   characters appearing "clipped". This is because many Asian scripts stack letters vertically
   (e.g. Indic scripts, Thai, Balinese etc.) but the line metrics of the merged font are
   optimized for LGC.
2. Tibetan has limited glyphs, otherwise GSUB table gets "overflow"ed. Only the most frequently
   occuring "subjoined consonants" are included. Those characters are displayed ok, but just that
   the glyphs appear to be "pushed up" compared to their neighbours.
3. Vertical text layout is not supported for CJK, Dogra, Mongolian, Nandinagari, Nüshu and Tangut,
   even though the upstream Noto Fonts has the support because fonttools does not support merging
   with `vmtx`/`vhea`.
4. Go Noto Kurrent has limited support for CJK -- it offers the full Unihan IICore subset plus more
   glyphs, so it should work ok-ish for daily use but there can be missing glyphs. As before,
   vertical text writing is not supported with this font.
5. Duployan has limited glyphs, also to avoid GSUB overflow. Cursive connections, contextual forms,
   and overlap trees are disabled. Shading and combining marks still work.

## License

In the spirit of _loka-saṃgraha_, the scripts distributed in this git repository (the "Software")
are dedicated to the public domain as per "The Unlicense". See UNLICENSE.txt.

However, the fonts generated by using the Software are licensed under the SIL Open Font License,
Version 1.1, as required by the upstream Noto Fonts Project.

### Others

Find font files and related known issues at

- [https://notofonts.github.io/](https://notofonts.github.io/)
- [https://github.com/notofonts/noto-cjk](https://github.com/notofonts/noto-cjk)

FontTools package comes with nice utilities `ttx` (ttf to xml and back), `pyftsubset` (create font
with subset of given font) and `pyftmerge` (merging fonts, the workhorse of this repo).

`libharfbuzz-bin` offers CLI utilities `hb-view` and `hb-shape` which are useful for visualising
rendered characters.

`otfinfo` gives useful info about glyphs, codepoints, scripts and more.

[1]: https://wikipedia.org/wiki/International_Ideographs_Core
[2]: https://github.com/googlefonts/noto-cjk/
[3]: https://unicode.org/charts/unihan.html
