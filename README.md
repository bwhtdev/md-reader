# md-reader (Markdown Reader for NixOS)

> *Reads markdown files without bloated Chromium*

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

### Test program locally
- Run `nix build`
- Run `./result/bin/md-reader example-readme.md`
