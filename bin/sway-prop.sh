#!/usr/bin/env bash
# https://gitlab.com/wef/dotfiles/-/blob/master/bin/sway-prop

TIME_STAMP="20211102.175342"

# Copyright (C) 2020-2021 Bob Hepple <bob dot hepple at gmail dot com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

PROG=$( basename $0 )

case "$1" in
    -h|--help)
        echo "Usage: $PROG"
        echo
        echo 'shows the properties of the focused window

best bindings:
bindsym  $mod+question exec sway-prop
bindsym $a+$c+question exec sway-prop

but if running from a terminal rather than a sway key binding:
sleep 2; sway-prop'
        exit 0
        ;;
esac

TMP=/tmp/sway-prop-$$.tmp

trap "rm $TMP" EXIT

swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true)' > "$TMP"

if [[ "$1" || -t 1 ]]; then
    cat "$TMP"
else
    # I prefer to popup a terminal eg:
    if type alacritty &> /dev/null; then
        alacritty --class floating -e bash -c "less $TMP"
    else
        # ... but sway doesn't have anything like i3-sensible-terminal.
        # swaynag is always installed with sway, so:
        swaynag -l -m "sway-prop" < "$TMP"
    fi
fi

# Local Variables:
# mode: shell-script
# time-stamp-pattern: "4/TIME_STAMP=\"%:y%02m%02d.%02H%02M%02S\""
# eval: (add-hook 'before-save-hook 'time-stamp)
# End:

