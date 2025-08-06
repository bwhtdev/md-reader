#!/usr/bin/env bash

# Example usage (for <markdown-file>):
# $ md-reader.sh <markdown-file>

# NOTE: Must have pandoc, html2pdf, zathura, entr installed

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <markdown-file>"
  exit 1
fi

# Extract the base filename
filename=$(basename "$1")

# Check if input file exists
if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' not found"
  exit 1
fi

# Temporary files
html_file="/tmp/$filename.html"
pdf_file="/tmp/$filename.pdf"

# Convert Markdown to HTML and then to PDF
pandoc "$filename" -o "$html_file" || {
  echo "Error: pandoc failed"
  exit 1
}
html2pdf "$html_file" -o "$pdf_file" || {
  echo "Error: html2pdf failed"
  exit 1
}

# Open PDF with zathura
zathura "$pdf_file" &

# Use entr to watch for changes and regenerate PDF
echo "$filename" | entr -s "pandoc $filename -o $html_file && html2pdf $html_file -o $pdf_file" &

# Cleanup files when zathura exits
wait $!
rm -f "$html_file" "$pdf_file"

#(echo $1.md | entr -s "pandoc $1.md -o $1.html && html2pdf $1.html && rm $1.html") &

#(zathura $1.pdf && rm $1.pdf) &
