tmux-world-clock
=============================

Tmux plugin that enables displaying multiple timezones in the tmux status line.

Introduces a new #{world_clock_status} format.

This plugin is useful if:

- you spend most of your time in Tmux and don't want to "switch" away from the terminal to check the
  current time.
- you regularly collaborate with people in different timezones and want to keep track of their
  local time.

Tested and working on OSX, but given most date logic is in python should also work on Linux and Cygwin.

![image](https://raw.githubusercontent.com/alexanderjeurissen/tmux-world-clock/master/screenshots/screenshot.png)

### Usage

The timezones are configurable and uses the Olson tz database. This means that you need to specify
the timezones in that format which for CET for example can be: `Europe/Amsterdam`

Add #{world_clock_status} format string to your existing status-right tmux option.

Example configuration for showing CET / PST / IST simultaniously:

    set -g @world_clock_tz 'Europe/Amsterdam'
    set -g @world_clock_tz 'US/Pacific'
    set -g @world_clock_tz 'Asia/Kolkata'

    set-option -g status-right "#[bg=blue, fg=black] #{world_clock_status "

There is no limit on the number of timezones that can be included this way (except from screen real
estate ;) )

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

### Requirements

This plugin uses python, and more specifically the `pytz` package to do the timezone magic, as such
having python 2.7 or python 3.0 installed is required for this plugin to work.
