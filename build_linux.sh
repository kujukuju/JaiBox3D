#!/bin/sh
set -eu

if [ "$(uname -m)" != "x86_64" ]; then
    echo "JaiBox3D Linux artifacts must be built on an x86_64 Linux host." >&2
    exit 1
fi

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BUILD_DIR="$ROOT_DIR/.build/linux-x64"
OUTPUT_DIR="$ROOT_DIR/bin/linux"

cmake \
    -S "$ROOT_DIR/../box3d" \
    -B "$BUILD_DIR" \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DBOX3D_SAMPLES=OFF \
    -DBOX3D_UNIT_TESTS=OFF \
    -DBOX3D_BENCHMARKS=OFF \
    -DBOX3D_DOCS=OFF \
    -DBOX3D_BUILD_SHADERS=OFF \
    -DBOX3D_PROFILE=OFF \
    -DBOX3D_VALIDATE=OFF \
    -DBOX3D_SANITIZE=OFF \
    -DBOX3D_DOUBLE_PRECISION=OFF

cmake --build "$BUILD_DIR" --target box3d --parallel

mkdir -p "$OUTPUT_DIR"
cp -P \
    "$BUILD_DIR/bin/libbox3d.so" \
    "$BUILD_DIR/bin/libbox3d.so.0.2" \
    "$BUILD_DIR/bin/libbox3d.so.0.2.0" \
    "$OUTPUT_DIR/"
