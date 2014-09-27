module R3Status::Blocks
  # A base block for blocks who need to run the update procedure at a 
  # different interval than general update interval, or ones who need
  # to run in the background.
  class Async < Base
    # The update interval (in seconds) of the block.
    attr_accessor :update_interval
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {update_interval: 3}.merge(args)
      super(args, &block)
    end
    
    # When first called, starts the update loop. Ignored afterwards.
    def update
      return unless @updater_thread.nil?
      @updater_thread = Thread.new do
        loop_with_interval(update_interval) { async_update }
      end
    end
    
    # Signals the block to release any resources.
    def terminate
      @updater_thread.kill
    end
    
    # When implemented in derived classes, updates the text and color of this block.
    # Implmentations should set the #full_text and #text_color attributes.
    def async_update; end
  end
end
