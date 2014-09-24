module R3Status
  class KeyboardLayoutBlock < Block
    def initialize(**args)
      super(args)
    end
    
    def update
      sym = language_symbol
      @full_text = formats[sym] % {val: sym, sym: sym}
      @text_color = colors[sym]
    end
    
    def language_symbol
      `xkblayout-state print %s`.chomp.to_sym
    end
  end
end
