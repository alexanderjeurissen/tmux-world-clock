#!/usr/bin/env bash

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option")"
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

set_tmux_option() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "$option" "$value"
}

update_tmux_option() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

_tmux_conf_contents() {
  cat /etc/tmux.conf ~/.tmux.conf 2>/dev/null
  if [ "$1" == "full" ]; then
    # also output content from sourced files
    local file
    for file in $(_sourced_files); do
      cat $(_manual_expansion "$file") 2>/dev/null
    done
  fi
}

time_zone_list_helper() {
	# read set -g @world_clock_tz "TZ" entries
	_tmux_conf_contents "full" |
		awk '/^[ \t]*set(-option)? +-g +@world_clock_tz/ { gsub(/'\''/,""); gsub(/'\"'/,""); print $4 }'
}
