{ lib, pkgs, config, ... }:

{
  programs.system-config-printer = {
    enable = true;
  };
}
