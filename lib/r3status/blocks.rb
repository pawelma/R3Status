module R3Status; end

require_relative './blocks/base.rb'

require_relative './blocks/clock.rb'

require_relative './blocks/volume.rb'

require_relative './blocks/power.rb'

require_relative './blocks/keyboard_layout.rb'

require_relative './blocks/shell.rb'

require_relative './blocks/async.rb'

require_relative './blocks/memory.rb'

require_relative './blocks/block_group.rb'

require_relative './blocks/disk.rb'

require_relative './blocks/playerctl.rb'
module R3Status
  # Alias for Blocks::Base
  Block               = Blocks::Base
  
  # Alias for Blocks::Base
  StaticBlock         = Blocks::Base
  
  # Alias for Blocks::Volume
  VolumeBlock         = Blocks::Volume
  
  # Alias for Blocks::Clock
  TimeBlock           = Blocks::Clock
  
  # Alias for Blocks::Power
  BatteryBlock        = Blocks::Power
  
  # Alias for Blocks::KeyboardLayout
  KeyboardLayoutBlock = Blocks::KeyboardLayout
  
  # Alias for Blocks::Async
  AsyncBlock          = Blocks::Async
  
  # Alias for Blocks::Shell
  ShellBlock          = Blocks::Shell
end
