module R3Status::Blocks
  # A block that shows information about media players through +playerctl+.
  # Allows the user to view track information and control the playback.
  # Requires the +playerctl+ executable in the PATH.
  #
  # ==== States
  #   :paused, :playing, :not_available, :stopped
  #
  # ==== Format values
  # * <tt>%{val}</tt>, <tt>%{title}</tt>: The current track's title.
  # * <tt>%{album}</tt>: The current track's album.
  # * <tt>%{artist}</tt>: The current track's artist.
  class PlayerCTL < Base
    # The name of the player to control. Default: the first available player (if any).
    attr_accessor :player_name
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {}.merge(args)
      super(args, &block)
    end
    
    # Updates the text and color of this block.
    def update
      title, album, artist = track_title, track_album, track_artist
      @text_color = colors[state]
      @full_text = formats[state] % { val: title, title: title, 
                                      album: album, artist: artist}
    end
    
    # Handles mouse interaction with the block.
    # If a block was supplied to the constructor, it will be yielded.
    # button (Fixnum):: The mouse button that was used.
    # x, y (Fixnum / Float):: The pointer coordinates on the screen.
    def clicked(button, x, y)
      super(button, x, y)
      case button
      when 1
        `#{player_name}` if state == :not_available
      when 4
        `playerctl next`
      when 2
        `playerctl play-pause`
      when 5
        `playerctl previous`
      end
    end
    
    # Returns the current state of the block
    def state
      s = `playerctl status`.strip.downcase.to_sym
      if [:paused, :playing, :stopped].include? s
        return s
      else
        return :not_available
      end
    end
    
    def track_title; metadata(:title) end
    def track_album; metadata(:album) end
    def track_artist; metadata(:artist) end
    
    def metadata type
      if player_name.nil?
        `playerctl metadata #{type}`
      else
        `playerctl --player=#{player_name} metadata #{type}`
      end.strip
    end
  end
end

