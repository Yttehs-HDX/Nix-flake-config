{ pkgs, ... }:

{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji-blob-bin
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      sansSerif = [
        "SF Pro"
        "Noto Sans CJK SC"
      ];
      serif = [ "Noto Serif CJK SC" ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Sans Mono CJK SC"
      ];
      emoji = [ "Blobmoji" ];
    };

    configFile = {
      "reject-bitmap" = {
        enable = true;
        priority = 10;
        text = ''
          <description>Reject bitmap fonts</description>
          <selectfont>
            <rejectfont>
              <pattern>
                <patelt name="scalable"><bool>false</bool></patelt>
              </pattern>
            </rejectfont>
          </selectfont>
        '';
      };

      "cjk-priority" = {
        enable = true;
        priority = 60;
        text = ''
          <description>Set CJK font priority per locale</description>

          <match target="pattern">
            <test name="lang" compare="contains"><string>ja</string></test>
            <test name="family"><string>sans-serif</string></test>
            <edit name="family" mode="prepend"><string>Noto Sans CJK JP</string></edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains"><string>zh-cn</string></test>
            <test name="family"><string>sans-serif</string></test>
            <edit name="family" mode="prepend"><string>Noto Sans CJK SC</string></edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains"><string>zh-tw</string></test>
            <test name="family"><string>sans-serif</string></test>
            <edit name="family" mode="prepend"><string>Noto Sans CJK TC</string></edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains"><string>ko</string></test>
            <test name="family"><string>sans-serif</string></test>
            <edit name="family" mode="prepend"><string>Noto Sans CJK KR</string></edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains"><string>ja</string></test>
            <test name="family"><string>serif</string></test>
            <edit name="family" mode="prepend"><string>Noto Serif CJK JP</string></edit>
          </match>
          <match target="pattern">
            <test name="lang" compare="contains"><string>zh-cn</string></test>
            <test name="family"><string>serif</string></test>
            <edit name="family" mode="prepend"><string>Noto Serif CJK SC</string></edit>
          </match>
          <match target="pattern">
            <test name="lang" compare="contains"><string>zh-tw</string></test>
            <test name="family"><string>serif</string></test>
            <edit name="family" mode="prepend"><string>Noto Serif CJK TC</string></edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains"><string>ja</string></test>
            <test name="family"><string>monospace</string></test>
            <edit name="family" mode="prepend"><string>Noto Sans Mono CJK JP</string></edit>
          </match>
          <match target="pattern">
            <test name="lang" compare="contains"><string>zh-cn</string></test>
            <test name="family"><string>monospace</string></test>
            <edit name="family" mode="prepend"><string>Noto Sans Mono CJK SC</string></edit>
          </match>
          <match target="pattern">
            <test name="lang" compare="contains"><string>zh-tw</string></test>
            <test name="family"><string>monospace</string></test>
            <edit name="family" mode="prepend"><string>Noto Sans Mono CJK TC</string></edit>
          </match>
        '';
      };
    };
  };
}
