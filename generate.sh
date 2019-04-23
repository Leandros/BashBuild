#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
readonly dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly execname="test"
if [ -z ${1+x} ]; then echo "usage: build.sh OUTDIR"; exit 1; fi

mkdir -p "$dir/$1"
rm -f "$dir/$1/build.ninja"
{ echo -ne "ninja_required_version = 1.7.2\nroot = ..\noutdir = .\n";
echo -ne "cxx = clang++\ncflags = -Wall -Wextra -std=c++17 -I\$root/src\nldflags =\n";
echo -ne "rule cxx
  command = \$cxx -MMD -MT \$out -MF \$out.d \$cflags -c \$in -o \$out
  description = CXX \$out
  depfile = \$out.d
  deps = gcc\n";
echo -ne "rule link
  command = \$cxx \$ldflags -o \$out \$in \$libs
  description = LINK \$out\n";
for f in "$dir/src/"*.cpp; do
    echo -ne "build \$outdir/$(basename -s .cpp "$f").o: cxx \$root/src/$(basename "$f")\n"
done;
echo -ne "build \$outdir/$execname: link "
for f in "$dir/src/"*.cpp; do
    echo -ne "\$outdir/$(basename -s .cpp "$f").o "
done;
echo -ne "\ndefault \$outdir/test\nbuild all: phony \$outdir/test\n"
} >> "$dir/$1/build.ninja"
