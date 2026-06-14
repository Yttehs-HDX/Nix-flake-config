{ pkgs, ... }:

let
  ocr-trans = pkgs.writeShellApplication {
    name = "ocr-trans";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.gnused
      pkgs.grim
      pkgs.slurp
      pkgs.tesseract
      pkgs.translate-shell
      pkgs.wl-clipboard
    ];
    text = ''
      set -e
      img=$(mktemp --suffix=.png /tmp/ocr-trans_XXXXXX)
      txt=$(mktemp /tmp/ocr-trans_XXXXXX)
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

      printf '%s' "$cleaned" | trans -b :zh-CN | wl-copy
    '';
  };
in
{
  home.packages = [ ocr-trans ];
}
