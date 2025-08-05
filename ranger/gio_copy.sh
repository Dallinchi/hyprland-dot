#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

gio copy "$1" "clipboard://"

