{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
  home.username = "matt";
  home.homeDirectory = "/home/matt";
  
  home.packages = with pkgs; [ 
    zsh 
    jq
    exercism
    silver-searcher
    asciinema
    gron
    pre-commit
    python310
    python310Packages.ipython
    black
    bat
  ] ;

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    jq.enable = true;
    dircolors.enable = true;
    htop.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
  	repo = "pure";
  	rev  = "v1.20.1";
  	sha256 = "1bxg5i3a0dm5ifj67ari684p89bcr1kjjh6d5gm46yxyiz9f5qla";
        };
      }
      {
        name = "today";
        src = ./zsh_functions;
        file = "today.zsh";
      }
    ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins;
      let
        vim-nix = pkgs.vimUtils.buildVimPlugin {
          name = "vim-nix";
          src = pkgs.fetchgit {
	    url = "https://github.com/LnL7/vim-nix";
            rev = "7d23e97d13c40fcc6d603b291fe9b6e5f92516ee";
	    sha256 = "1vaprm79j0nfl37r6lw0zwd048ajd5sc9cvny59qwdl3x0zk38av";
          };
        };
      in [
        vim-nix
        # pkgs.vimPlugins.coc-pyright
        # todo: try coc-pylsp
      ];
  };

    programs.git = {
    enable = true;
    userName = "Matt Rixman";
    userEmail = "MatrixManAtYrService@users.noreply.github.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
  };
}
