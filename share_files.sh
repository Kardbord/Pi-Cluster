#!/bin/bash

HOSTFILE="./hostfile"

share_files () {
    while read node; do
        scp  "$1" "$node:/home/test/"
    done < $HOSTFILE
}

if [[ "$#" -lt 1 || ( "$1" != *.cpp && "$1" != *.py ) ]]; then

    echo -e "\nProvide a cpp or py file.\n"
    exit 0

fi

if [[ "$1" == *.cpp ]]; then
    # CPP FILE PROVIDED

    mpic++ "$1" || exit 1
    share_files "a.out"

    exit 0

else
    # PY FILE PROVIDED

    share_files "$1"
fi
