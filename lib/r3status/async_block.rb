module R3Status
  class AsyncBlock < Block
    attr_accessor :update_interval, :updater_thread
    
    def initialize(**args)
      args = {update_interval: 3}.merge(args)
      super(args)
    end
    
    def update
      @full_text
      return if @updater_pid.is_a? Fixnum
      @updater_thread = Thread.new do
        loop_with_interval(update_interval) { async_update }
      end
    end
    
    def terminate
      @updater_thread.kill
    end
    
    def async_update; end
  end
end
