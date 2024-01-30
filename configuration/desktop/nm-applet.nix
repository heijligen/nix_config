{ lib, pkgs, config, ... }:

{
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
