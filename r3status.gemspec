Gem::Specification.new do |s|
  s.name        = 'r3status'
  s.version     = '0.1.2'
  s.licenses    = ['LGPL3']
  s.summary     = 'i3status replacement written in ruby.'
  s.description = 'r3status is ruby implmentation of the i3bar protocol, and is an alternative to the default i3status.'
  s.authors     = ['Gilad Naaman']
  s.email       = 'gilad.doom@gmail.com'
  s.files       = ['lib/r3status.rb', 
                    'lib/r3status/blocks.rb',
                    'lib/r3status/blocks/base.rb',
                    'lib/r3status/blocks/power.rb',
                    'lib/r3status/blocks/keyboard_layout.rb',
                    'lib/r3status/blocks/clock.rb',
                    'lib/r3status/blocks/volume.rb',
                    'lib/r3status/blocks/async.rb',
                    'lib/r3status/blocks/shell.rb']
  s.homepage    = 'https://github.com/Gilnaa/R3Status'
  s.add_runtime_dependency 'json'
end
