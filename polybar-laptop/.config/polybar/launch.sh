#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar
echo "---" | tee -a /tmp/polybar-mainbar.log
polybar mainbar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bar launched..."
