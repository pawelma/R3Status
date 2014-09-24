module R3Status
  class TimeBlock < Block
    attr_accessor :format
    
    def initialize(format: "%H:%m @ %e/%M/%Y", **args)
      @format = format
      
      super()
    end
    def update
      self.full_text = Time.now.strftime(format)
    end
  end
end
