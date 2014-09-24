module R3Status
  class VolumeBlock < Block
    attr_accessor :format, :format_muted, :default_color, :color_muted, :step
    
    def initialize(**args)
      args = {formats: {muted: " %{volume}%", unmuted: " %{volume}%"},
              colors: {muted: '#7CCdCD', unmuted: '#ffffff'}, step: 5,
              name: "volume_master"}.merge(args)
      
      super(args)
    end
    
    def update
      vol = volume
      muted = muted? ? :muted : :unmuted
      @text_color = colors[muted]
      @full_text = formats[muted] % {val: vol, volume: vol}
    end
    
    def clicked button, x, y
      case button
      when 1, 4
        increase
      when 2
        toggle_mute
      when 3, 5
        decrease
      end
    end
    
    private
    def toggle_mute
      `amixer -q set Master toggle`
    end
    def increase
      `amixer -c 0 set Master #{step}+ unmute`
    end
    def decrease
      `amixer -c 0 set Master #{step}- unmute`
    end
    def volume
      `amixer -c 0 get Master | grep Mono: | cut -d " " -f6 | tr -d [,],%`.to_i
    end
    def muted?
      `amixer -c 0 get Master | grep Mono: | cut -d " " -f8 | tr -d [,]`.chomp == "off"
    end
  end
end
