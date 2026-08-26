#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BUILD_DIR="$ROOT_DIR/.build/macos-arm64"
OUTPUT_DIR="$ROOT_DIR/bin/macos"

cmake \
    -S "$ROOT_DIR/../box3d" \
    -B "$BUILD_DIR" \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DBOX3D_SAMPLES=OFF \
    -DBOX3D_UNIT_TESTS=OFF \
    -DBOX3D_BENCHMARKS=OFF \
    -DBOX3D_DOCS=OFF \
    -DBOX3D_PROFILE=OFF \
    -DBOX3D_VALIDATE=OFF \
    -DBOX3D_DOUBLE_PRECISION=OFF \
    -DCMAKE_OSX_ARCHITECTURES=arm64 \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
    -DCMAKE_C_COMPILER=/usr/bin/clang \
    -DCMAKE_CXX_COMPILER=/usr/bin/clang++

cmake --build "$BUILD_DIR" --config Release --target box3d --parallel

mkdir -p "$OUTPUT_DIR"
cp -L "$BUILD_DIR/bin/libbox3d.dylib" "$OUTPUT_DIR/libbox3d.dylib"
install_name_tool -id '@rpath/libbox3d.dylib' "$OUTPUT_DIR/libbox3d.dylib"
