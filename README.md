# tmux-world-clock
Show 12 hour clock for two timezones

Still very much WIP, I bootstrapped this so I can refer to this tmux plugin and remove some
hardcoded configuration in my tmux config. Currently the time zones are configurable but that's
about it.

configuration:

```
  set -g @tmux_world_clock_tz_one "Europe/Amsterdam"
  set -g @tmux_world_clock_tz_two "US/Pacific"

  set-option -g status-right "#{world_clock_status"
```
