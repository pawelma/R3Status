module R3Status::Blocks
  # A block that acts as a volume indicator.
  # It displays the current Master Volume, and allows to user to change it using scrolling,
  # and muting using the middle mouse button.
  #
  # ==== States
  #   :muted, :unmuted
  #
  # ==== Format values
  # +%{val}+, +%{volume}+: The current system volume.
  class Volume < Base
    # The amount of volume (in percents) to change with scroll.
    attr_accessor :step
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {formats: {muted: " %{volume}%", unmuted: " %{volume}%"},
              colors: {muted: '#7CCdCD', unmuted: '#ffffff'}, step: 5,
              name: "volume_master"}.merge(args)
      
      super(args, &block)
    end
    
    # Updates the text and color of this block.
    def update
      vol = volume
      muted = muted? ? :muted : :unmuted
      @text_color = colors[muted]
      @full_text = formats[muted] % {val: vol, volume: vol}
    end
    
    # Handles mouse interaction with the block.
    # If a block was supplied to the constructor, it will be yielded.
    # button (Fixnum):: The mouse button that was used.
    # x, y (Fixnum / Float):: The pointer coordinates on the screen.
    def clicked(button, x, y)
      super(button, x, y)
      case button
      when 4
        increase
      when 2
        toggle_mute
      when 5
        decrease
      end
    end
    
    # Toggles the mute state of the system volume.
    def toggle_mute
      `amixer -q set Master toggle`
    end
    
    # Increases the system volume by the given amount.
    # step:: The amount of volume to increase. If +nil+, the value default value,
    # or the one supplied in the constructor, will be used.
    def increase(step = nil)
      `amixer -c 0 set Master #{step || @step}%+ unmute`
    end
    
    # Decreases the system volume by the given amount.
    # step:: The amount of volume to decrease. If +nil+, the value default value,
    # or the one supplied in the constructor, will be used.
    def decrease(step = nil)
      `amixer -c 0 set Master #{step || @step}%- unmute`
    end
    
    # Returns the current system volume.
    def volume
      `amixer -c 0 get Master | grep Mono: | cut -d " " -f6 | tr -d [,],%`.to_i
    end
    
    # Returns the mute state of the system volume.
    def muted?
      `amixer -c 0 get Master | grep Mono: | cut -d " " -f8 | tr -d [,]`.chomp == "off"
    end
    
    # Returns the current state of the block
    def state
      muted? ? :muted : :unmuted
    end
  end
end
