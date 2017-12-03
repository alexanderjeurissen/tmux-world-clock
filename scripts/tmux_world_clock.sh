#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

tz_one_default_value="US/Pacific"
tz_one="$(get_tmux_option "@tmux_world_clock_tz_one" "$tz_one_default_value")"

tz_two_default_value="Europe/Amsterdam"
tz_two="$(get_tmux_option "@tmux_world_clock_tz_one" "$tz_one_default_value")"

_get_date_time() {
python - $1 <<-EOF
import sys
import string
import pytz
from datetime import datetime

tz = sys.argv[1]
date = datetime.now(pytz.timezone(tz))

formatted_time = date.strftime("%I:%M %p")
tz_name = date.tzname()

print "#[bold]{0}#[nobold]: {1}".format(tz_name, formatted_time)
EOF
}

print_time_info() {
  echo "$(_get_date_time "$tz_one") | $(_get_date_time "$tz_two")"
}

print_time_info
