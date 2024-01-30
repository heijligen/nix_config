{ config, lib, pkgs, ... }:
{
  # nixpkgs.config.chromium.commandLineArgs = "--gtk-version=4 --password-store=gnome-libsecret";

  imports = [
    ./modules/shikane.nix
    ./configuration/desktop
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    use-xdg-base-directories = true;
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      systemd-boot = {
        enable = true;
	editor = false;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [
      "nouveau"
    ];
    extraModprobeConfig = lib.mkMerge [
      "options snd_hda_intel power_save=1"
      "options iwlwifi power_save=1 uapsd_disable=1"
    ];
    initrd = {
      systemd.enable = true;
      availableKernelModules = [ "xhci_pci" "ahci" ];
      luks.devices = {
        "root".device = "/dev/disk/by-uuid/bcd552a8-2f1d-4c21-9d2c-8eaae375f757";
	"home".device = "/dev/disk/by-uuid/161ee96e-d029-4129-af7c-7bf37894cb25";
      };
    };
  };

  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
    systemPackages = with pkgs; [
      tree
      htop
      file 
      fd
      xdg-ninja
      silver-searcher
      killall
      python3Packages.ipython
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/bf50d373-a50d-4bfc-b43f-d63e0ebf57c3";
      fsType = "xfs";
      options = [ "defaults" "relatime" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/c629fdcc-dc5e-4978-8884-b2762fc863c2";
      fsType = "xfs";
      options = [ "defaults" "relatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/EC3B-6053";
      fsType = "vfat";
    };
  };

  hardware = {
    cpu.intel = {
      updateMicrocode = true;
    };
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      nvidiaSettings = false;
      powerManagement.enable = true;
    };
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
	      intel-compute-runtime
      ];
    };
  };

  
  networking = {
    hostName = "odin";
    networkmanager = {
      enable = true;
      # dns = "systemd-resolved";
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
  };

  programs = {
    git = {
      enable = true;
      config = {
        user = {
          name = "Thomas Heijligen";
          email = "src@posteo.de";
        };
        init.defaultBranch = "main";
      };
    };
    adb.enable = true;
    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };
    captive-browser = {
      enable = true;
      interface = "wlp3s0";
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      viAlias = true;
      vimAlias = true;
      configure = {
        customRC = ''
          inoremap <silent><expr> <CR>
            \ coc#pum#visible() ? coc#pum#confirm() :
            \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
        '';
        packages.myVimPackages = with pkgs.vimPlugins; {
          start = [
            vimtex
            coc-nvim
            coc-vimlsp
            coc-vimtex
            coc-rust-analyzer
            vim-latex-live-preview
            coc-clangd
          ];
        };
      };
      runtime = {
        "ftplugin/nix.vim".text = ''
	        set tabstop=2
	        set shiftwidth=2
	        set expandtab
	      '';
        "ftplugin/ada.vim".text = ''
          set tabstop=3
          set shiftwidth=3
          set expandtab
        '';
        "ftplugin/tex.vim".text = ''
          set tabstop=2
          set shiftwidth=2
          set expandtab
        '';
      };
    };
    evolution.enable = true;
  };

  services = {
    dbus.implementation = "broker";
    greetd = {
      enable = true;
      settings.default_session = {
        # command = "systemctl --user start nixos-fake-graphical-session.target";
	command = "sway";
	user = "user";
      };
    };
    printing = {
      enable = true;
    };
    #thinkfan = {
    #  enable = true;
    #};
    xserver.videoDrivers = [ "nvidia" ]; # only for triggering hardware.nvidia
  };

  system.stateVersion = "23.11";
 
  users.users."user" = {
    extraGroups = [
      "wheel"
      "networkmanager"
      "adbusers"
      "docker"
      "video"
    ];
    isNormalUser = true;
    packages = with pkgs; [
      libreoffice
      gomuks
      chromium
      gnome3.seahorse
      helvum # pipewire gui
      gnome3.evince
      unzip
      mpv
      imv
      mosh
      darktable
      inkscape
      gnome.ghex
      latexrun
      gnumake
      texliveFull
      wl-clipboard
      rust-analyzer
      cargo
      clang-tools
    ];
  };
 
  virtualisation = {
    docker.enable = true;
  };

}
