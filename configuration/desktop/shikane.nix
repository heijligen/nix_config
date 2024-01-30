{ lib, pkgs, config, ... }:

{
  programs.shikane = {
    enable = true;
    environment = {
      SHIKANE_LOG = "trace";
    };
    extraPackages = with pkgs; [
      libnotify
    ];
    settings = {
      profile = [ {
        name = "default";
        # exec = [ "${pkgs.libnotify}/bin/notify-send foo" ];
	# exec = [ "sh" ];
        output = [ {
          match = "eDP-1";
          enable = true;
        } ];
      } {
        name = "docking";
        output = [ {
          match = "eDP-1";
          enable = false;
        } {
          match = "/201NTHM4L657/";
	  enable = true;
          mode = {
            width = 3840;
            height = 2160;
            refresh = 30;
          };
        } {
          match = "/201NTKF4L693/";
          enable = true;
          mode = {
            width = 3840;
            height = 2160;
            refresh = 30;
          };
        } ];
      } ];
    };
  };
}
