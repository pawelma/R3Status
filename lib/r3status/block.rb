module R3Status
  class Block
    DEFAULT_COLOR = '#ffffff'
    DEFAULT_FORMAT = '%{val}'
    
    attr_accessor :full_text, :text_color, :name, :formats, :colors
    
    def initialize(**args)
      self.colors ||= {}
      self.formats ||= Hash.new(DEFAULT_FORMAT)
      args.each do |k, v|
        v.default = v[:default] if (v.is_a? Hash) && (v.key? :default)
        send "#{k}=", v
      end
    end
    
    def update; end
     
    def terminate; end
     
    def clicked(button, x, y); end
    
    def to_s(prefix: nil, postfix: nil)
      %({"full_text": "#{prefix}#{full_text}#{postfix}", 
          "color": "#{text_color || DEFAULT_COLOR}", "name": "#{name}",
          "separator": false})
    end
    
    def format
      formats.default 
    end
    
    def format=(fmt)
      @formats.default = fmt 
    end
  end
end
