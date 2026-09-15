#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
OUTPUT_DIR="$ROOT_DIR/.build/smoke-test-linux"
JAI=${JAI:-jai}

mkdir -p "$OUTPUT_DIR"
cp -P "$ROOT_DIR"/bin/linux/libbox3d.so* "$OUTPUT_DIR/"

cd "$ROOT_DIR"
"$JAI" smoke_test.jai -output_path "$OUTPUT_DIR"
LD_LIBRARY_PATH="$OUTPUT_DIR" "$OUTPUT_DIR/smoke_test"
