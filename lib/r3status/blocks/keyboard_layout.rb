module R3Status::Blocks
  # A block that acts as a keyboard layout indicator.
  #
  # ==== States
  # There are no constant states. A state is the current keyboard layout,
  # as specified by the system. (e.g. +:us+ for US English, +:ru+ for Russian)
  #
  # ==== Format values
  # 8 <tt>%{val}</tt>, <tt>%{sym}</tt>: The current language symbol.
  class KeyboardLayout < Base
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      super(args, &block)
    end
    
    # Updates the text and color of this block.
    def update
      sym = state
      @full_text = formats[sym] % {val: sym, sym: sym}
      @text_color = colors[sym]
    end
    
    # Returns the current state of the block.
    def state
      if command? "xkblayout-state"
        `xkblayout-state print %s`
      else
        `setxkbmap -query | awk -F"(|[ ]+)" '/layout:/ { print $2 }'`
      end.chomp.to_sym
    end
    
    # Determines if a shell command exists.
    def command?(command)
       system("which #{command} > /dev/null 2>&1")
    end
  end
end
