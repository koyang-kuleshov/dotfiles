#!/bin/bash

input=$(slurp -o -f "%o")
/usr/libexec/xdg-desktop-portal-wlr -r & /usr/libexec/xdg-desktop-portal-wlr -r -o "$input" &
