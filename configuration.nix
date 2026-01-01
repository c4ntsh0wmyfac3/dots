{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  #Basic options
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;
  boot.consoleLogLevel = 3;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  #user
  users.users.a = {
    isNormalUser = true;
    description = "a";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  #sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  #Window manager
  services.displayManager.ly.enable = true;
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs {
      src = /home/a/.config/dwm;
    };
  };
  services.xserver = {
    enable = true;
    xkb = {
     layout = "us,ru";
     options = "grp:alt_shift_toggle,ctrl:nocaps";
    };
    #windowManager.bspwm.enable = true;
  };
  console.useXkbConfig = true;

  #Programms & packages
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    gcc
    clang
    cl
    zig
  ];

  #fonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  nixpkgs.config.allowUnfree = true;
  #system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git  
    alacritty
    dmenu
    # neovim
    (writeShellScriptBin "nvim" ''
      exec /home/a/.bin/nvim-linux-x86_64/bin/nvim "$@"
    '')
    firefox
    openvpn
    stow  
    lf
    xfce.thunar
    gnutar
    unzip
    tmux
    pavucontrol
    neofetch
    sxhkd
    xorg.xinit
    polybar
    dunst
    rofi
    picom
    zsh
    nitrogen
    feh
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    zoxide
    fzf
    xclip
    gcc
    clang
    zig
    cl
    go
    gopls
    lua-language-server
    lua
    tree
    htop
    dysk
    libnotify
    xcolor
    killall
    slock
  ];

  #automaticly generation deleting
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "25.11"; # Did you read the comment?

}
