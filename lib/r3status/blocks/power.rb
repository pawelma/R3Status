module R3Status::Blocks
  # A block that acts as a power indicator.
  #
  # ==== States:
  #   :charging, :discharging, :full, :unknown, :no_battery
  #
  # ==== Format Values
  # +%{val}+, +%{capacity}+: The current battery capacity.
  class Power < Base
    # The path of the battery on the disk. Examples:
    #  * /sys/class/power_supply/BAT1/
    #  * /proc/acpi/battery/BAT0/
    attr_accessor :path
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {colors: {charging: '#6DBB45', discharging: '#F4C91D'},
              formats: {charging: 'Bat(charge) %{capacity}%',
                        default: 'Bat %{capacity}%'}}.merge(args)
      super(args, &block)
      
      
      @path = get_battery_path if path.nil?
      path << '/' if path[-1] != '/'
    end
    
    # Updates the text and color of this block.
    def update
      cap, st = capacity, state
      
      @full_text = formats[st] % {val: cap, capacity: cap, state: st}
      @text_color = colors[st]
    end
    
    # Returns the current state of the block
    def state
      return :no_battery unless File.exist? path
      `cat #{path}status`.chomp.downcase.to_sym 
    end
    
    # Returns the current capacity of the battery, or +nil+ if no battery found.
    def capacity
      return nil if state == :no_battery
      `cat #{path}capacity`.chomp.to_i
    end
    
    # Try to find a valid battery path.
    def get_battery_path
      base_paths = ["/proc/acpi/battery/", "/sys/class/power_supply/"]
      base_paths.each do |p|
        if Dir.exist? p
          return p + (Dir.entries(p) - %w{ . .. }).last
        end
      end
      
    end
  end
end
