#!/bin/sh

for dir in */; do
    [ -d "$dir" ] || continue
    echo "==> Entering $dir"
    cd "$dir"

    if [ ! -f Makefile ]; then
        echo "No Makefile found, skipping."
        cd ..
        continue
    fi

    make clean install && make clean

    cd ..
done
