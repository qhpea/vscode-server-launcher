#!/bin/sh
TMP_DIR=$(mktemp -d)
OUT_DIR="$TMP_DIR/vscode-server-launcher"
mkdir -p "$OUT_DIR"

for arch in aarch64 x86_64; do
  for target in unknown-linux-gnu unknown-linux-musl apple-darwin-signed; do
    url=https://aka.ms/vscode-server-launcher/$arch-$target
    out_file=$OUT_DIR/$arch-$target
    curl -sSL "$url" -o "$out_file"
    chmod +x "$out_file"
  done
done
