{ lib, pkgs, config, ... }:

{

  imports = [
    ./nm-applet.nix
    ./pipewire.nix
    ./printing.nix
    ./shikane.nix
    ./sway.nix
    ./waybar.nix
  ];

  environment.sessionVariables = {
    XDG_DATA_HOME        = "$HOME/.local/share";
    XDG_STATE_HOME       = "$HOME/.local/state";
    XDG_CONFIG_HOME      = "$HOME/.local/config";
    XDG_CACHE_HOME       = "$HOME/.local/cache";
    HISTFILE             = "$XDG_STATE_HOME/bash/history";
    CUDA_CACHE_PATH      = "$XDG_CACHE_HOME/nv";
    GOPATH               = "$XDG_DATA_HOME/go";
    GNUPGHOME            = "$XDG_DATA_HOME/gnupg";
    NIXOS_OZONE_WL       = "1";
    LD_LIBRARY_PATH      = "$LD_LIBRARY_PATH:${pkgs.libsecret}/lib";
    NIXPKGS_ALLOW_UNFREE = "1";
    PERF_CONFIG          = "$XDG_CONFIG_HOME/perf/config";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
  ];

  services = {
    blueman.enable = true;
    gnome.evolution-data-server.enable = true;
    upower.enable = true;
  };

}
