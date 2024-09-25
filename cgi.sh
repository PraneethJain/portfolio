#!/bin/bash

names=(index links about projects)
mkdir -p cgi-bin
for name in "${names[@]}"; do
    fasm "cgi/${name}.asm"
    mv "cgi/${name}" "cgi-bin/${name}.cgi"
done
