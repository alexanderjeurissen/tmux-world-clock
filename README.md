tmux-world-clock
=============================

Tmux plugin that enables displaying multiple timezones in the tmux status line.

Introduces a new #{world_clock_status} format.

This plugin is useful if:

- you spend most of your time in Tmux and don't want to "switch" away from the terminal to check the
  current time.
- you regularly collaborate with people in a different timezone and want to keep track of their
  local time.

Tested and working on OSX, but given most date logic is in python should also work on Linux and Cygwin.

![image](https://raw.githubusercontent.com/alexanderjeurissen/tmux-world-clock/master/screenshots/screenshot.png)

### Usage

The timezones are configurable and uses the Olson tz database. This means that you need to specify
the timezones in that format which for CET for example can be: `Europe/Amsterdam`

Add #{world_clock_status} format string to your existing status-right tmux option.

Example configuration:

    set -g @tmux_world_clock_tz_one "Europe/Amsterdam"
    set -g @tmux_world_clock_tz_two "US/Pacific"

    set-option -g status-right "#[bg=blue, fg=black] #{world_clock_status"

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'alexanderjeurissen/tmux-world-clock'

Hit `prefix + I` to fetch the plugin and source it.

`#{world_clock_status}` interpolation should now work.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/alexanderjeurissen/tmux-world-clock ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/tmux_world_clock_status.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

`#{world_clock_status}` interpolation should now work.
