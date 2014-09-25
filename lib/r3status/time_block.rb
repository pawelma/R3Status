module R3Status
  class TimeBlock < Block
    
    def initialize(**args)
      args = {format: "%H:%m @ %e/%M/%Y"}.merge(args)
      super(args)
    end
    
    def update
      self.full_text = Time.now.strftime(format)
    end
  end
end
