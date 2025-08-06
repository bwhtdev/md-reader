# md-reader

> *Reads markdown files without bloated Chromium*

..

### Install on Nix
Add package to Nix config (`/etc/nixos/configuration.nix`):
```nix
{
  environment.systemPackages = with pkgs; [
    (builtins.getFlake "path:/home/user/md-reader").packages.${system}.md-reader
  ];
}
```
```
```
