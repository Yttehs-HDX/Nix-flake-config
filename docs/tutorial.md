# 使用教程

## 目录结构

```
├── flake.nix
├── home/username/              # 用户配置
├── hosts/nixos/hostname/      # 主机配置
├── modules/
│   ├── nixos/                 # NixOS 系统模块
│   └── home/                  # Home Manager 模块（扁平结构）
│       ├── desktop/           # 桌面环境（如 hyprland）
│       └── theme/             # 主题
└── docs/                      # 文档
```

## 模块组织

`modules/home/` 下的所有 `.nix` 文件均为平铺结构，不区分 packages、programs、services。每个文件声明一个包或服务。

Hyprland 相关的模块集中在 `modules/home/desktop/hyprland/`，由 `default.nix` 统一导入。

## 定义新用户

### 1. 创建用户目录

```
home/<username>/
```

### 2. 编写 default.nix

`home/<username>/default.nix` — 基础配置，导入公共模块：

```nix
{ inputs, ... }:

{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/zsh.nix
    ../../modules/home/nvim.nix
    ../../modules/home/kitty.nix
    ../../modules/home/tmux.nix
    # ... 其他模块
  ];

  home.username = "<username>";
  home.homeDirectory = "/home/<username>";

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}
```

### 3. 编写主机配置

`home/<username>/laptop.nix` — 桌面配置，在 default.nix 基础上叠加桌面环境：

```nix
{ ... }:

{
  imports = [
    ./default.nix
    ../../modules/home/desktop/hyprland
    ../../modules/home/theme/catppuccin-mocha
  ];
}
```

### 4. 注册到 flake.nix

```nix
homeConfigurations."<user>@<host>" =
  home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs; };
    modules = [ ./home/<username>/laptop.nix ];
  };
```

## 定义新主机

### 1. 创建主机目录

```
hosts/nixos/<hostname>/
```

### 2. 编写 default.nix

`hosts/nixos/<hostname>/default.nix` — 主机入口，导入系统模块：

```nix
{ inputs, ... }:

{
  imports = [
    ./boot.nix
    ./locale.nix
    ./graphics.nix
    ./hardware-configuration.nix
    ./users.nix
    ./desktop.nix
    ./home.nix

    ../../../modules/nixos/nix.nix
    ../../../modules/nixos/networking.nix
    # ... 其他系统模块
  ];

  programs.zsh.enable = true;
  networking.hostName = "<hostname>";
  system.stateVersion = "25.11";
}
```

### 3. 编写子配置

- **hardware-configuration.nix** — 由 `nixos-generate-config` 生成，保留内核模块、文件系统、swap 等纯硬件配置
- **boot.nix** — 引导加载器配置（从 hardware-configuration.nix 抽离）
- **locale.nix** — 时区和语言环境（从 hardware-configuration.nix 抽离）
- **graphics.nix** — 显卡 prime bus ID（从 hardware-configuration.nix 抽离）
- **users.nix** — 系统用户和用户组
- **desktop.nix** — 桌面环境（导入 `modules/nixos/desktop/` 下的模块）
- **home.nix** — Home Manager 集成，指定用户的 home 配置

```nix
# hosts/nixos/<hostname>/users.nix
{ pkgs, ... }:
{
  users.users.<username> = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
```

```nix
# hosts/nixos/<hostname>/home.nix
{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };

  home-manager.users.<username> = import ../../../home/<username>/laptop.nix;
}
```

### 4. 注册到 flake.nix

```nix
nixosConfigurations."<hostname>" = nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [ ./hosts/nixos/<hostname> ];
};
```
