#!/bin/sh

set -e

ADVCPMV_VERSION=${1:-0.9}
CORE_UTILS_VERSION=${2:-9.5}

DIR_NAME="coreutils-$CORE_UTILS_VERSION"
PATCH_NAME="advcpmv-$ADVCPMV_VERSION-$CORE_UTILS_VERSION.patch"

if [ ! -d "$DIR_NAME" ]; then
    echo "Error: Directory '$DIR_NAME' not found."
    exit 1
fi

if [ ! -f "$PATCH_NAME" ]; then
    echo "Error: Patch file '$PATCH_NAME' not found."
    exit 1
fi

(
    cd "$DIR_NAME"
    patch -p1 -i "../$PATCH_NAME"
    ./configure
    make
    cp ./src/cp ../advcp
    cp ./src/mv ../advmv
)