Gem::Specification.new do |s|
  s.name        = 'r3status'
  s.version     = '0.1.1'
  s.licenses    = ['LGPL3']
  s.summary     = 'i3status replacement written in ruby.'
  s.description = 'r3status is ruby implmentation of the i3bar protocol, and is an alternative to the default i3status.'
  s.authors     = 'Gilad Naaman'
  s.email       = 'gilad.doom@gmail.com'
  s.files       = ['lib/r3status.rb', 
                    'lib/r3status/block.rb',
                    'lib/r3status/blocks.rb',
                    'lib/r3status/battery_block.rb',
                    'lib/r3status/keyboard_layout_block.rb',
                    'lib/r3status/static_block.rb',
                    'lib/r3status/time_block.rb',
                    'lib/r3status/volume_block.rb',
                    'lib/r3status/async_block.rb',
                    'lib/r3status/shell_block.rb']
  s.homepage    = 'https://github.com/Gilnaa/R3Status'
end
