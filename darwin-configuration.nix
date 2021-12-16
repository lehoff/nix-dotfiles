{ config, lib, pkgs, ... }:

{

  homebrew = {
      enable = true;
      taps = [ "homebrew/core" "homebrew/cask" ];

      casks = [
	"bettertouchtool"
	"fork"
	"visual-studio-code"
	"alfred"
	"controlplane"
	"docker"
	"karabiner-elements"
	"vivaldi"
	"firefox"
	"iterm2"
	"mailmate"
	"qmk-toolbox"
	"reflector"
	"ripgrep"
	"skim"
	"slack"
	"speedtest-cli"
	"telegram"
	"ukelele"
	"whatsapp"
	"xmind"
	"zoom"
      ];
  };

}


