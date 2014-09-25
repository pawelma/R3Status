require 'securerandom'

module R3Status
  class StaticBlock < Block
    attr_accessor :clicked_block
    
    def initialize(**args, &block)
      @clicked_block = block
      
      super(args)
      
      @full_text ||= format
      @name ||= SecureRandom.uuid
    end
    
    def clicked(button, x, y)
      return if @clicked_block.nil?
      args = [self, button, x, y].take(@clicked_block.arity)
      @clicked_block.(*args)
    end
  end
end
