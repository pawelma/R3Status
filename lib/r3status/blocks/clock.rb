module R3Status::Blocks
  # A block that displays the current date and time.
  #
  # ==== States
  #   :am, :pm
  #
  # ==== Format values
  # See http://www.ruby-doc.org/core-2.1.3/Time.html#method-i-strftime
  class Clock < Base
  
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {format: "%H:%m %e/%M/%Y"}.merge(args)
      super(args, &block)
    end
    
    # Updates the text and color of this block.
    def update
      self.full_text = Time.now.strftime(formats[state])
    end
    
    # Returns the current state of the block
    def state
      Time.now.strftime('%P').to_sym
    end
  end
end
