#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

world_clock_status="#($CURRENT_DIR/scripts/tmux_world_clock.sh)"
world_clock_status_interpolation_string="\#{world_clock_status}"

source $CURRENT_DIR/scripts/helpers.sh

do_interpolation() {
  local string="$1"
  local interpolated="${string/$pomodoro_status_interpolation_string/$world_clock_status}"
  echo "$interpolated"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}
main
