require 'securerandom'
# Contains the default blocks that can be used using StatusLine.
module R3Status::Blocks  
  # A base class for blocks, providing the needed methods and attributes.
  # Can be use both as a base for other blocks and as a block in itself.
  #
  # ==== Examples
  #   b = Blocks::Base.new(full_text: "0") do |block, button|
  #     block.full_text = button.to_s
  #   end
  class Base
    # The default text color. Will be used if no color was supplied, or +nil+ was given.
    DEFAULT_COLOR = '#ffffff'
    # The default format. Will be used if no format was supplied, or +nil+ was given.
    DEFAULT_FORMAT = '%{val}'
    
    attr_accessor( 
      :full_text,
      :text_color,
      :name,
      :formats, 
      :colors, 
      :clicked_block,
    )
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {colors: {}, formats: Hash.new(DEFAULT_FORMAT)}.merge(args)

      args.each do |k, v|
        v.default = v[:default] if (v.is_a? Hash) && (v.key? :default)
        send "#{k}=", v
      end
      
      @clicked_block = block
      @name ||= SecureRandom.uuid
      @full_text ||= format
    end
    
    # When implemented in derived classes, updates the text and color of this block.
    # Implmentations should set the #full_text and #text_color attributes.
    def update; end
     
    # Handles mouse interaction with the block.
    # If a block was supplied to the constructor, it will be yielded.
    # button (Fixnum):: The mouse button that was used.
    # x, y (Fixnum / Float):: The pointer coordinates on the screen.
    def clicked(button, x, y)
      return if @clicked_block.nil?
      args = [self, button, x, y].take(@clicked_block.arity)
      @clicked_block.(*args)
    end
    
    # Returns the string representation of this block.
    def to_s(prefix: nil, postfix: nil)
      %({"full_text": "#{prefix}#{full_text}#{postfix}", 
          "color": "#{text_color || DEFAULT_COLOR}", "name": "#{name}",
          "separator": false})
    end
    
    # Returns the default format string.
    def format
      formats.default 
    end
    
    # Sets the default format string.
    def format=(fmt)
      formats.default = fmt 
    end
    
    # Returns the default color.
    def color
      colors.default
    end
    
    # Sets the default color.
    def color=(color)
      colors.default = color
    end
    
    # Signals the block to release any resources.
    def terminate; end
    
    # When implemented in derived class, returns the current state of the block,
    # if available.
    def state; end
  end
end
