#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

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

print("#[bold]{0}#[nobold]: {1}".format(tz_name, formatted_time))
EOF
}

print_time_info() {
  local timezones="`time_zone_list_helper`"
  local last_timezone=""

  for timezone in $timezones; do
    if [ ! -z $last_timezone ]; then
      printf "$(_get_date_time "$last_timezone") | "
    fi
    last_timezone=$timezone
  done

  # Process last timezone and don't include separator
  if [ ! -z $last_timezone ]; then
    printf "$(_get_date_time "$last_timezone")"
  fi
}

print_time_info
