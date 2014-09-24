# R3Status #

## Introduction ##

R3Status is replacement to i3's `i3status`. Written in ruby, it has compatability with the i3bar protocol, and a wider range of feature than i3status.

## Installation ##

```
gem install r3status
```

## Usage ##

R3Status is used by creating a starter script, and running it from within i3.

The library consists of a status line (`R3Status::StatusLine`) and blocks.
A status line represents one "task bar", and contains "blocks".
A block is an indicator that has text and color, and can respond to mouse clicks.

#### Example ####
File: `~/bin/r3status_start.rb`:

```ruby
require 'r3status'

status = R3Status::StatusLine.new
status << R3Status::VolumeBlock.new
status << R3Status::TimeBlock.new

status.run
```

In ~/.i3/config:

```
bar {
  #status_command i3status
  status_command $HOME/bin/r3status_start.rb
}
```

## Capabilities  ##

#### Text and Color ####

Each block has a `full_text` field which is set each bar update, as well as a `text_color` field.
These fields, although settable, will usually won't be set by the user; instead, when possible,
the user will provide a set of colors and a set of formats, from which the block will choose the most suitable according to its current state.

The colors are in the form of #RRGGBB, and the format is the standard ruby format string.
Each block has different set values for the format string, but the format string can also use '%{val}', which is always set by the block
to a "default" value. (e.g. the volume percentage in the volume block)

```ruby
BAT_PATH = "/sys/class/power_supply/BAT1/"
status_line << BatteryBlock.new(path: BAT_PATH, 
    formats: {charging: "   %{capacity}%", discharging: "  %{capacity}\%"},
    colors: {full: '#69B842', charging: '#F4C91D', discharging: '#9B3E9B'})

```

When passing a hash to the block constructor (for `formats` or `colors`), a special hash value can be specified,
and it'll be used as the default value in case the block couldn't find a suitable value.

```ruby
BAT_PATH = "/sys/class/power_supply/BAT1/"
status_line << BatteryBlock.new(path: BAT_PATH, 
    formats: {charging: "   %{capacity}%", default: "  %{capacity}\%"},
    colors: {default: '#69B842', charging: '#F4C91D', discharging: '#9B3E9B'})

```

#### Click Events ####

R3Status is able to process the click events recieved by i3bar.
When clicked, a block will recieve the clicked mouse button (Left, Right, Middle, Scroll-Up, Scroll-Down) and the click's coordinates.
Some of the default blocks use this capability when appropriate (try scrolling over the volume block, or clicking it with the middle mouse button).

The static block can recieve a block, through the constructor, that will be yielded when the block is clicked.

#### API Reference ####

_soon_

#### Extending `R3Status::Block`

_soon_

#### Examples ####

_soon_
