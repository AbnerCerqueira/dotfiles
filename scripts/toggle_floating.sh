#! /bin/bash

active_window=$(hyprctl activewindow -j)
is_floating=$(echo "$active_window" | grep '"floating": true')

if [[ -n "$is_floating" ]]; then
  hyprctl dispatch settiled
else
  monitor_id=$(hyprctl activeworkspace -j | jq -r '.monitorID')
    
  window_w=1600
  window_h=900

  if [[ "$monitor_id" == "1" ]]; then
      window_w=720
      window_h=1152
  fi

  hyprctl dispatch togglefloating \
  && hyprctl dispatch resizeactive exact $window_w $window_h \
  && hyprctl dispatch centerwindow
fi
