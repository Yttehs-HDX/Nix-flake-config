{ pkgs, ... }:

let
  ocr = pkgs.writeShellApplication {
    name = "ocr";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.gnused
      pkgs.grim
      pkgs.slurp
      pkgs.tesseract
      pkgs.wl-clipboard
    ];
    text = ''
      set -e
      img=$(mktemp --suffix=.png /tmp/ocr_XXXXXX)
      txt=$(mktemp /tmp/ocr_XXXXXX)
      trap 'rm -f "$img" "$txt" "$txt.txt"' EXIT

      region=$(slurp) || exit 0
      grim -g "$region" "$img"

      tesseract "$img" "$txt" -l chi_sim+eng+jpn --psm 6
      raw=$(cat "$txt.txt" 2>/dev/null || true)

      cleaned=$(printf '%s' "$raw" \
          | tr -d '\r' \
          | paste -s -d ' ' - \
          | sed 's/[[:space:]]\+/ /g; s/^ //; s/ $//' \
      )

      printf '%s' "$cleaned" | wl-copy
    '';
  };
in
{
  home.packages = [ ocr ];
}
