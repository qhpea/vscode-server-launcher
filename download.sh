#!/bin/sh
OUT_DIR="$GITHUB_WORKSPACE/bin"

# if out_dir exists, remove it

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

for arch in aarch64 x86_64; do
  for target in unknown-linux-gnu unknown-linux-musl apple-darwin-signed; do
    url=https://aka.ms/vscode-server-launcher/$arch-$target
    out_file=$OUT_DIR/$arch-$target
    curl -sSL "$url" -o "$out_file"
    chmod +x "$out_file"
  done
done

# install code-server to determine version
# wget -O- https://aka.ms/install-vscode-server/setup.sh | sh


VERSION=$( "$OUT_DIR/x86_64-unknown-linux-gnu" --version | grep -ow '[0-9.]*')

# ouput version
echo "version=$VERSION" >> $GITHUB_OUTPUT