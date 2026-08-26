#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
OUTPUT_DIR="$ROOT_DIR/.build/smoke-test"

mkdir -p "$OUTPUT_DIR"
cp "$ROOT_DIR/bin/macos/libbox3d.dylib" "$OUTPUT_DIR/libbox3d.dylib"

cd "$ROOT_DIR"
jai smoke_test.jai -output_path "$OUTPUT_DIR"
"$OUTPUT_DIR/smoke_test"
