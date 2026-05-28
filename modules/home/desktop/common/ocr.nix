{ pkgs, ... }:

let
  ocr = pkgs.writeShellApplication {
    name = "ocr";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.gnused
      pkgs.grimblast
      pkgs.tesseract
      pkgs.wl-clipboard
    ];
    text = ''
      set -e
      img=$(mktemp /tmp/ocr_XXXXXX.png)
      txt=$(mktemp /tmp/ocr_XXXXXX)
      trap 'rm -f "$img" "$txt" "$txt.txt"' EXIT
      grimblast --freeze save area "$img" >/dev/null 2>&1
      tesseract "$img" "$txt" -l chi_sim+eng+jpn --psm 6
      raw=$(cat "$txt.txt")
      cleaned=$(printf "%s" "$raw" \
          | tr -d '\r' \
          | sed ':a;N;$!ba;s/\n/ /g' \
          | sed 's/[[:space:]]\+/ /g' \
          | sed 's/^[ \t]*//;s/[ \t]*$//' \
      )
      echo -n "$cleaned" | wl-copy
    '';
  };
in
{
  home.packages = [ ocr ];
}
