#!/usr/bin/env bash
# DESCRIPTION
#   Select all text node and create a union of them
#
# USAGE
#   bash ./resources/scripts/svg-text2svg-font.bash
#
# @author: Édouard Lopez <dev+hpf@edouard-lopez.com>

scriptDir="$(dirname "$0")" # emplacement du script
. "$scriptDir"/envrc # project variables

inputFile="${2:-"$HPF_UNIHAN_READING_SHORT"}"


Xvfb :8 -screen 0 1024x768x8 -extension RANDR &> /dev/null &
# Fake a X server
XVFB_PID=$!
echo $XVFB_PID > ./xvfb.pid
export DISPLAY=":8"

printf "Removing existing SVG-font files…\n"
rm "$HPF_SVGFONT_DIR"/*.svg

inkscapeOptions=(
  --select=canvas --select=hanzi --verb=AlignHorizontalLeft --verb=EditDeselect
  --select=canvas --select=pinyin --verb=AlignHorizontalRight --verb=EditDeselect
  --select=canvas --verb=EditDelete --select=hanzi --select=pinyin
  --verb=AlignVerticalCenter --verb=SelectionUnion --verb=FileSave --verb=FileQuit
)

for f in "$HPF_SVGTEXT_DIR"/*.svg;
do
  nf="$HPF_SVGFONT_DIR/${f##*/}"
  cp "$f" "$nf" ;

  printf "creating SVG-font: %s\n" "$nf"
  inkscape -f "$nf" "${inkscapeOptions[@]}"
done

kill $XVFB_PID
