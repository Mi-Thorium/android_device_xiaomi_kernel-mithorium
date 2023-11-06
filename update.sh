#!/bin/bash

LINEAGE_PRODUCT_OUT="$1"
[ -d "$LINEAGE_PRODUCT_OUT" ] || exit 1

DEVICES=$(find . -mindepth 1 -maxdepth 1 -type d -not -name '.*'|sed 's|\./||g')

for d in $DEVICES; do
    if [ ! -d "$LINEAGE_PRODUCT_OUT/$d" ]; then continue; fi
    rm -f $d/*.*
    cp $LINEAGE_PRODUCT_OUT/$d/obj/KERNEL_OBJ/arch/arm64/boot/Image.gz-dtb $LINEAGE_PRODUCT_OUT/$d/vendor/lib/modules/*.ko $d/
    if [ -f "$LINEAGE_PRODUCT_OUT/$d/dtbo.img" ]; then
        cp $LINEAGE_PRODUCT_OUT/$d/dtbo.img $d/
    fi
    chmod 644 $d/*.*
done

exit 0
