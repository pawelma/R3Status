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

## API Reference ##

### StatusLine ###
A class representing the status bar. Blocks can be added, and will be displayed.

#### Properties ####
_prefix (String)_ - A string the will be added into the start of every block.

_postfix (String)_ - A string the will be added into the end of every block.

_update_interval (Fixnum / Float)_ - The time between each bar update.

### Block ###
A base class for all the blocks. Can be used as a dumb text display.

#### Properties ####
_full_text (String)_ - The displayed text. Will be used to update the bar.

_text_color (String)_ - The text's color. Will be used to update the bar.

_name (String)_ - The name of the block. This property is optional, but it must be set for the block to recieve click events

_formats (Hash)_ - A hash of formats. The keys should be symbols representing the block's states (as specified by each subclass),
the keys should be strings.

_colors (Hash)_ - A hash of colors. The keys should be symbols representing the block's states (as specified by each subclass),
the keys should be strings.

_format (String)_ Gets or sets the default format.

### TimeBlock < Block ###
A simple time indicator. Has no state. Format string should be in ruby's time format (as used in strftime).

#### Properties ####
_Inherited_

#### States ####
_None_

#### Format Values ####
_N/A_

#### Examples ####
```ruby
status_line << TimeBlock.new
status_line << TimeBlock.new(format: " %H:%M    %e/%m/%Y")
```

### BatteryBlock < Block ###
A battery indicator.

#### Properties ####

_path (String)_ - The path of the battery in the filesystem (e.g. "/sys/class/power_supply/BAT1/", or "/proc/acpi/battery/BAT0/")

_Inherited_

#### States ####
`:charging, :discharging, :full, :unknown`

#### Format Values ####
_val_, _capacity_ - The battery percentage (without the '%' sign).

_status_ - The battery status.

#### Examples ####
```ruby
bat_path = "/sys/class/power_supply/BAT1/"

status_line << BatteryBlock.new(path: bat_path)
status_line << BatteryBlock.new(path: bat_path,
    formats: {charging: "   %{capacity}%", default: "  %{capacity}\%"},
    colors: {full: '#69B842', charging: '#F4C91D', discharging: '#9B3E9B'})
```

### VolumeBlock < Block ###
An indicator showing the system volume (using `amixer`), allowing the user to raise, lower, and mute it.

#### Properties ####

_step (Fixnum)_ - The amount of volume (in %) to lower / raise when the block is scrolled.

_Inherited_

#### States ####
`:muted, :unmuted`

#### Format Values ####
_val_, _volume_ - The current volume (without the '%' sign).

#### Examples ####
```ruby
status_line << VolumeBlock.new
status_line << VolumeBlock.new(formats: {muted: "%{volume}(muted)"})
status_line << VolumeBlock.new(colors: {muted: '#ff0000'})
```

### KeyboardLayoutBlock < Block ###
Displays the current keyboard layout (using the xkblayout-state utility).

#### Properties ####
_Inherited_

#### States ####
Depends on the system configuration. A state is the symbol of the current layout (e.g., _:us_ for en_US)

#### Format Values ####
_val_, _sym_ - The symbol of the current keyboard layout.

#### Examples ####
```ruby
status_line << KeyboardLayoutBlock.new
status_line << KeyboardLayoutBlock.new(formats: {us: "1) EN", ru: "2) RU"},
                                       colors: {us: '#42B3FB', ru: '#FB4942'})
```


_more soon_




## Extending `R3Status::Block` ##

_soon_

## Examples ##

```ruby
#!/usr/bin/env ruby
require_relative 'r3status'
BAT_PATH = "/sys/class/power_supply/BAT1/"

include R3Status
# Creates a StatusLine object.
status_line = StatusLine.new(prefix: '\t')

# Adds a battery status indicator
# (icons best displayed using FontAwesome)
status_line << BatteryBlock.new(path: BAT_PATH, 
    formats: {charging: "   %{capacity}%", default: "  %{capacity}\%"},
    colors: {full: '#69B842', charging: '#F4C91D', discharging: '#9B3E9B'})

# Adds keyboard layout display
status_line << KeyboardLayoutBlock.new(formats: {il: " HE", us: " EN"},
    colors: {il: '#5E88EF', us: '#B82E27'})

# Adds a new volume indicator
# Responds to mouse click (lower/raise/mute)
status_line << VolumeBlock.new

# Adds a clock
status_line << TimeBlock.new(format: " %H:%M    %e/%m/%Y")
status_line.run
```
