# R3Status [![Gem Version](https://badge.fury.io/rb/r3status.svg)](http://badge.fury.io/rb/r3status)

## Introduction ##

R3Status is replacement to i3's `i3status`. Written in ruby, it has compatability with the i3bar protocol, and a wider range of feature than i3status.

You can request a feature or a block by creating a github issue.

## Installation ##

```
gem install r3status
```

## Usage ##

R3Status is used by creating a starter script, and running it from within i3.

The library consists of a status line (`R3Status::StatusLine`) and blocks (Found in the `R3Status::Blocks` module).
A status line represents one "task bar", and contains "blocks".
A block is an indicator that has text and color, and can respond to mouse clicks.
All default blocks derive from `R3Status::Blocks::Base`, but any object can be used as long as it has the following methods:

```ruby
  def update; end
  def to_s(prefix, postfix); end
  def terminate; end
```

Each block has a set of `formats` and `colors`, that help the block choose the best suitable values based on the block's state.
At any given time, a block is in one of several states (as defined by each block class).

As well as the `formats` and `colors` hashes, a block also has the `format` and `color` attributes,
which gets and sets the _defualt_ color and format. The default values will be used if no format or value
was specified for the current state.
## List of Blocks ##
* Volume indicator
* Clock
* Power indicator
* Keyboard Layout indicator
* Disk indicator
* Layout indicator
* PlayerCTL indicator
* Group
* ASync [use at own risk]
* Shell [use at own risk]
#### Example ####
File: `~/bin/r3status_start.rb`:

```ruby
require 'r3status'

status = R3Status::StatusLine.new
status << R3Status::Blocks::Volume.new
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

See http://rubydoc.info/gems/r3status/

## Extending `R3Status::Blocks::Base` ##

_soon_ (In the meantime, have a look at the source code and maybe you'll figure out)

## Examples ##
An older example was using classes such as `VolumeBlock`, `TimeBlock`, and `BatteryBlock`;
These classes are now deprecated in favour of `Blocks::Volume`, `Blocks::Clock`, and `Blocks::Power`.
```ruby
require 'r3status'

include R3Status
include R3Status::Blocks


status_line = StatusLine.new(prefix: '\t')

system = BlockGroup.new
system << Memory.new(format: '  %{val}%', colors: {high: '#ff3333'})
status_line << system

indicators = BlockGroup.new

indicators << Power.new(
    formats: {charging: "   %{capacity}%", default: "  %{capacity}\%"},
    colors: {full: '#69B842', charging: '#F4C91D', discharging: '#9B3E9B'}
    )

indicators << KeyboardLayout.new(
    formats: {il: "  HE", us: "  EN"},
    colors: {il: '#5E88EF', us: '#B82E27'}
    )

indicators << Volume.new
status_line << indicators
time = BlockGroup.new(blocks: [
  Clock.new(format: " %H:%M"),
  Clock.new(format: " %e/%m/%Y"),
])

status_line << time

status_line.run
```
