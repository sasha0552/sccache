#!/bin/sh -e

# Install musl-tools 
sudo apt-get update && sudo apt-get install --yes musl-tools

# Install rust
curl -fssL https://sh.rustup.rs | sh /dev/stdin -y

# Load environment variables
. "$HOME/.cargo/env"

# Install rust for musl
rustup target add x86_64-unknown-linux-musl

# Build sccache
cargo build --features="dist-client dist-server" --release --target=x86_64-unknown-linux-musl

# Set default repository
gh repo set-default sasha0552/sccache

# Create release
gh release create $1 target/x86_64-unknown-linux-musl/release/sccache target/x86_64-unknown-linux-musl/release/sccache-dist
