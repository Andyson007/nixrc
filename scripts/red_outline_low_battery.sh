if systemd-ac-power --low -eq 0; then
  hyprctl --instance 0 keyword general:col.active_border 0xffff0000
  hyprctl --instance 0 keyword general:border_size 5
else
  hyprctl --instance 0 keyword general:border_size 1
  hyprctl --instance 0 keyword general:col.active_border 0xffffff00
fi
