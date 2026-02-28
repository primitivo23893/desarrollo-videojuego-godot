#!/bin/sh
printf '\033c\033]0;%s\a' Practica1
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Practica1.x86_64" "$@"
