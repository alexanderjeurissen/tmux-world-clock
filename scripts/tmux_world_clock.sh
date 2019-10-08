#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

_get_date_time() {
python - $* <<-EOF
import sys
import string
import pytz
from datetime import datetime

tz   = sys.argv[1]
bg   = sys.argv[2]
fg   = sys.argv[3]
fmt  = sys.argv[4]

date = datetime.now(pytz.timezone(tz))
tz_name = date.tzname()

#- fmt: replace %tz by the timezone name
#- fmt: replace "_" by " " (blanks break arg list)
date_fmt = fmt.replace("%tz", tz_name)
date_fmt = date_fmt.replace("_", " ")

formatted_time = date.strftime(date_fmt)

# set color output formatting if not "default"
fgstr="" if fg=="default" else '#[fg='+fg+']'
bgstr="" if bg=="default" else '#[bg='+bg+']'

print fgstr+bgstr+" "+formatted_time
EOF
}

print_time_info() {

  #-- process options from tmux config file(s)
  local h_bgcolor="`time_zone_bg_helper`"
  local h_fgcolor="`time_zone_fg_helper`"
  local h_fmt="`time_zone_fmt_helper`"
  local h_separator="`time_zone_separator_helper`"
  local timezones="`time_zone_list_helper`"
  
  #-- set options that were not present to default values
  # The colors should not be set if the options are not
  # present. We cannot pass empty strings to the python
  # part, so we use "default" which gets removed later.

  local fgcolor=${h_fgcolor:="default"}
  local bgcolor=${h_bgcolor:="default"}
  local fmt=${h_fmt:="#[bold]%tz#[nobold]:_%I:%M"}
  local separator=${h_separator:="|"}


  local last_timezone=""

  #-- loop over all but the last timezone, print and add separator
  for timezone in $timezones; do
    if [ ! -z $last_timezone ]; then
      echo -n "$(_get_date_time "$last_timezone" "$bgcolor" "$fgcolor" "$fmt") $separator"
    fi
    last_timezone=$timezone
  done

  # Process last timezone, print without separator
  if [ ! -z $last_timezone ]; then
    echo -n "$(_get_date_time "$last_timezone" "$bgcolor" "$fgcolor" "$fmt") "
  fi

  #-- this echo (outputs <lf>) is mandatory
  #   if not given, all plugins are run all the time with no scheduling
  #   not sure if this is desired behavior or a bug
  echo ""
}

print_time_info
