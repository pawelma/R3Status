module R3Status
  class BatteryBlock < Block
    attr_accessor :path
    
    def initialize(**args)
      args = {colors: {charging: '#6DBB45', discharging: '#F4C91D'},
              formats: {charging: 'Bat(charge) %{capacity}%',
                        default: 'Bat %{capacity}%'}}.merge(args)
      super(args)
    end
    
    def update
      cap, st = capacity, status
      
      @full_text = formats[st] % {val: cap, capacity: cap, status: st}
      @text_color = colors[st]
    end
    
    private
    def status; `cat #{path}status`.chomp.downcase.to_sym end
    def capacity; `cat #{path}capacity`.chomp end
  end
end
