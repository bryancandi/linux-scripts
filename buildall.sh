#!/usr/bin/env bash
#
# build-all.sh
#
# Iterate over all .c source files in the current directory and invoke
# `make <filename>` for each one (with the .c extension removed).
#
# This script is intended for projects where each .c file corresponds
# to an individual build target defined in the Makefile.
#
# The script continues building even if some targets fail, and prints
# a summary of any failures at the end.
#

shopt -s nullglob

failed=()

for file in *.c; do
    target="${file%.c}"
    echo "Building $target"

    if ! make "$target"; then
        echo "❌ Failed: $target"
        failed+=("$target")
    fi
done

if (( ${#failed[@]} > 0 )); then
    echo
    echo "Builds failed:"
    printf '  %s\n' "${failed[@]}"
    exit 1
else
    echo
    echo "✅ All builds succeeded"
fi
