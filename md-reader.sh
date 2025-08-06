#/bin/bash

# Example usage (for README.md):
# $ md-reader.sh README

# NOTE: Must have pandoc, html2pdf, zathura, entr installed

(echo $1.md | entr -s "pandoc $1.md -o $1.html && html2pdf $1.html && rm $1.html") &

(zathura $1.pdf && rm $1.pdf) &

# TODO: Make an installable Nix flake
