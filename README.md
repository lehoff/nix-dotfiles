# nix-dotfiles

Configuration of my macbook using Nix et al.

# update the nix version

nix flake update

# update packages

```
sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'
```


# Uninstall 

https://iohk.zendesk.com/hc/en-us/articles/4415830650265-Uninstall-nix-on-MacOS