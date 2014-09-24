module R3Status
  class StaticBlock < Block
    attr_accessor :clicked_block
    
    def initialize(**args, &block)
      @clicked_block = block
      
      super(args)
    end
    
    def clicked(button, x, y)
      return if clicked_block.nil?
      args = [self, button, x, y].take(clicked_block.arity)
      clicked_block.call(*args)
    end
  end
end
