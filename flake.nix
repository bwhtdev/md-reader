{
  description = "Read Markdown Files without Bloated Chromium";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        name = "md-reader";
        src = self;
        buildInputs = with pkgs; [ pandoc html2pdf zathura entr ];
        nativeBuildInputs = with pkgs; [ makeWrapper ];
        installPhase = ''
          mkdir -p $out/bin
          cp ${self}/md-reader.sh $out/bin/md-reader
          chmod +x $out/bin/md-reader
          wrapProgram $out/bin/md-reader \
            --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.pandoc pkgs.html2pdf pkgs.zathura pkgs.entr ]}
        '';
      };

      defaultPackage.${system} = self.packages.${system}.default;
    };
}
