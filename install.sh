#!/bin/sh
# SPDX-FileCopyrightText: 2024 Radosław Piliszek <radek@piliszek.it>
# SPDX-License-Identifier: MPL-2.0

set -e
set -u

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

target_bindir="$HOME/.local/bin"

mkdir -p "$target_bindir"
cp "$dir"/bin/* "$target_bindir/"
