require 'vmstat'
module R3Status::Blocks
  # A block that displays the system's memory consumption
  #
  # ==== States
  #   :low, :normal, :high
  #
  # ==== Format values
  # * <tt>%{val}</tt>, <tt>%{consumption}</tt>: Memrory consumption (in precentage,  without a percent sign).
  # * <tt>%{free}</tt>: The number of free pages in the system.
  # * <tt>%{active}</tt>: The number of active pages in the system.
  # * <tt>%{inactive}</tt>: The number of inactive pages in the system.
  # * <tt>%{wired}</tt>: The number of wired pages in the system.
  # * <tt>%{free_bytes}</tt>: The number of free bytes in the system.
  # * <tt>%{active_bytes}</tt>: The number of active bytes in the system.
  # * <tt>%{inactive_bytes}</tt>: The number of inactive bytes in the system.
  # * <tt>%{wired_bytes}</tt>: The number of wired bytes in the system.
  # * <tt>%{total_bytes}</tt>: The total number of bytes in the system.
  # * <tt>%{pagesize}</tt>: The page size of the memory in bytes.
  class Memory < Base
  
    # Determines the memory consumption that will be considered low.
    attr_accessor :low_threshold 
    # Determines the memory consumption that will be considered high.
    attr_accessor :high_threshold
    # The number of figures after the decimal point.
    attr_accessor :figures
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {low_threshold: 20, high_threshold: 90,
              figures: 0, format: 'ram: %{val}%'}.merge(args)
      super(args, &block)
    end
    
    # Updates the text and color of this block.
    def update
      @memory = memory = Vmstat.memory
      s = state
      @full_text = formats[s] % {
              val: consumption, consumption: consumption, free: memory.free,
              active: memory.active, inactive: memory.inactive, wired: memory.wired,
              pagesize: memory.pagesize, free_bytes: memory.free_bytes,
              active_bytes: memory.active_bytes, inactive_bytes: memory.inactive_bytes,
              wired_bytes: memory.wired_bytes, total_bytes: memory.total_bytes
      }                           
    end
    
    # Returns the current state of the block
    def state
      if consumption <  low_threshold
        :low
      elsif consumption > high_threshold
        :high
      else
        :normal
      end
    end
    
    # Returns the memory consumption in percents.
    def consumption
      (100 * (1 - @memory.free_bytes / @memory.total_bytes.to_f)).round(figures)
    end
  end
end
