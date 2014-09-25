module R3Status
  class ShellBlock < StaticBlock
    attr_accessor :command, :click_commands
    
    def initialize(**args, &block)
      super(args, &block)
    end
    
    def update
      return if command.nil?
      
      cmd = `#{command}`.split.map {|str| str.chomp}
      return if cmd.length == 0
      
      @full_text = cmd[0]
      @text_color = cmd[1] if cmd.length >= 2
    end
    
    def clicked(button, x, y)
      super(button, x, y)
      
      case click_commands.class
      when String
        `#{click_commands}`
      when Array
        `#{click_commands[button - 1]}`
      when Hash
        `#{click_commands[button]}`
      end
    end
  end
end
