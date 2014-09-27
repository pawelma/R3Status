var search_data = {"index":{"searchIndex":["r3status","blocks","async","base","clock","keyboardlayout","memory","power","shell","volume","statusline","<<()","async_update()","capacity()","clicked()","clicked()","clicked()","color()","color=()","command?()","decrease()","format()","format=()","get_battery_path()","increase()","loop_with_interval()","muted?()","new()","new()","new()","new()","new()","new()","new()","new()","new()","percentage()","run()","state()","state()","state()","state()","state()","terminate()","terminate()","to_hash()","to_s()","toggle_mute()","update()","update()","update()","update()","update()","update()","update()","update()","volume()","r3status.gemspec","readme"],"longSearchIndex":["r3status","r3status::blocks","r3status::blocks::async","r3status::blocks::base","r3status::blocks::clock","r3status::blocks::keyboardlayout","r3status::blocks::memory","r3status::blocks::power","r3status::blocks::shell","r3status::blocks::volume","r3status::statusline","r3status::statusline#<<()","r3status::blocks::async#async_update()","r3status::blocks::power#capacity()","r3status::blocks::base#clicked()","r3status::blocks::shell#clicked()","r3status::blocks::volume#clicked()","r3status::blocks::base#color()","r3status::blocks::base#color=()","r3status::blocks::keyboardlayout#command?()","r3status::blocks::volume#decrease()","r3status::blocks::base#format()","r3status::blocks::base#format=()","r3status::blocks::power#get_battery_path()","r3status::blocks::volume#increase()","r3status#loop_with_interval()","r3status::blocks::volume#muted?()","r3status::blocks::async::new()","r3status::blocks::base::new()","r3status::blocks::clock::new()","r3status::blocks::keyboardlayout::new()","r3status::blocks::memory::new()","r3status::blocks::power::new()","r3status::blocks::shell::new()","r3status::blocks::volume::new()","r3status::statusline::new()","r3status::blocks::memory#percentage()","r3status::statusline#run()","r3status::blocks::base#state()","r3status::blocks::clock#state()","r3status::blocks::keyboardlayout#state()","r3status::blocks::power#state()","r3status::blocks::volume#state()","r3status::blocks::async#terminate()","r3status::blocks::base#terminate()","r3status::blocks::memory#to_hash()","r3status::blocks::base#to_s()","r3status::blocks::volume#toggle_mute()","r3status::blocks::async#update()","r3status::blocks::base#update()","r3status::blocks::clock#update()","r3status::blocks::keyboardlayout#update()","r3status::blocks::memory#update()","r3status::blocks::power#update()","r3status::blocks::shell#update()","r3status::blocks::volume#update()","r3status::blocks::volume#volume()","",""],"info":[["R3Status","","R3Status.html","",""],["R3Status::Blocks","","R3Status/Blocks.html","","<p>Contains the default blocks that can be used using StatusLine.\n"],["R3Status::Blocks::Async","","R3Status/Blocks/Async.html","","<p>A base block for blocks who need to run the update procedure at a \ndifferent interval than general update …\n"],["R3Status::Blocks::Base","","R3Status/Blocks/Base.html","","<p>A base class for blocks, providing the needed methods and attributes. Can\nbe use both as a base for other …\n"],["R3Status::Blocks::Clock","","R3Status/Blocks/Clock.html","","<p>A block that displays the current date and time.\n<p>States\n\n<pre>:am, :pm</pre>\n"],["R3Status::Blocks::KeyboardLayout","","R3Status/Blocks/KeyboardLayout.html","","<p>A block that acts as a keyboard layout indicator.\n<p>States\n<p>There are no constant states. A state is the current …\n"],["R3Status::Blocks::Memory","","R3Status/Blocks/Memory.html","",""],["R3Status::Blocks::Power","","R3Status/Blocks/Power.html","","<p>A block that acts as a power indicator.\n<p>States:\n\n<pre>:charging, :discharging, :full, :unknown, :no_battery</pre>\n"],["R3Status::Blocks::Shell","","R3Status/Blocks/Shell.html","",""],["R3Status::Blocks::Volume","","R3Status/Blocks/Volume.html","","<p>A block that acts as a volume indicator. It displays the current Master\nVolume, and allows to user to …\n"],["R3Status::StatusLine","","R3Status/StatusLine.html","","<p>This class encapsulates a status output. Blocks are added by the user and\nare displayed each iteration. …\n"],["<<","R3Status::StatusLine","R3Status/StatusLine.html#method-i-3C-3C","(block)","<p>Appends a new block to this StatusLine object.\n"],["async_update","R3Status::Blocks::Async","R3Status/Blocks/Async.html#method-i-async_update","()","<p>When implemented in derived classes, updates the text and color of this\nblock. Implmentations should …\n"],["capacity","R3Status::Blocks::Power","R3Status/Blocks/Power.html#method-i-capacity","()","<p>Returns the current capacity of the battery, or <code>nil</code> if no\nbattery found.\n"],["clicked","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-clicked","(button, x, y)","<p>Handles mouse interaction with the block. If a block was supplied to the\nconstructor, it will be yielded. …\n"],["clicked","R3Status::Blocks::Shell","R3Status/Blocks/Shell.html#method-i-clicked","(button, x, y)",""],["clicked","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-i-clicked","(button, x, y)","<p>Handles mouse interaction with the block. If a block was supplied to the\nconstructor, it will be yielded. …\n"],["color","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-color","()","<p>Returns the default color.\n"],["color=","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-color-3D","(color)","<p>Sets the default color.\n"],["command?","R3Status::Blocks::KeyboardLayout","R3Status/Blocks/KeyboardLayout.html#method-i-command-3F","(command)","<p>Determines if a shell command exists.\n"],["decrease","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-i-decrease","(step = nil)","<p>Decreases the system volume by the given amount.\n<p>step &mdash; The amount of volume to decrease. If <code>nil</code>, the value …\n\n"],["format","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-format","()","<p>Returns the default format string.\n"],["format=","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-format-3D","(fmt)","<p>Sets the default format string.\n"],["get_battery_path","R3Status::Blocks::Power","R3Status/Blocks/Power.html#method-i-get_battery_path","()","<p>Try to find a valid battery path.\n"],["increase","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-i-increase","(step = nil)","<p>Increases the system volume by the given amount.\n<p>step &mdash; The amount of volume to increase. If <code>nil</code>, the value …\n\n"],["loop_with_interval","R3Status","R3Status.html#method-i-loop_with_interval","(secs)","<p>Loops over the given block at the specified interval. The interval is the\ntime between yields, not between …\n"],["muted?","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-i-muted-3F","()","<p>Returns the mute state of the system volume.\n"],["new","R3Status::Blocks::Async","R3Status/Blocks/Async.html#method-c-new","(**args, &block)","<p>Creates a new instance of this class. If a block is passed, it will be\nstored and yielded when the block …\n"],["new","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-c-new","(**args, &block)","<p>Creates a new instance of this class. If a block is passed, it will be\nstored and yielded when the block …\n"],["new","R3Status::Blocks::Clock","R3Status/Blocks/Clock.html#method-c-new","(**args, &block)","<p>Creates a new instance of this class. If a block is passed, it will be\nstored and yielded when the block …\n"],["new","R3Status::Blocks::KeyboardLayout","R3Status/Blocks/KeyboardLayout.html#method-c-new","(**args, &block)","<p>Creates a new instance of this class. If a block is passed, it will be\nstored and yielded when the block …\n"],["new","R3Status::Blocks::Memory","R3Status/Blocks/Memory.html#method-c-new","(**args, &block)",""],["new","R3Status::Blocks::Power","R3Status/Blocks/Power.html#method-c-new","(**args, &block)","<p>Creates a new instance of this class. If a block is passed, it will be\nstored and yielded when the block …\n"],["new","R3Status::Blocks::Shell","R3Status/Blocks/Shell.html#method-c-new","(**args, &block)",""],["new","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-c-new","(**args, &block)","<p>Creates a new instance of this class. If a block is passed, it will be\nstored and yielded when the block …\n"],["new","R3Status::StatusLine","R3Status/StatusLine.html#method-c-new","(prefix: \" \", postfix: nil, update_interval: 0.4)","<p>Creates a new StatusLine object.\n"],["percentage","R3Status::Blocks::Memory","R3Status/Blocks/Memory.html#method-i-percentage","()",""],["run","R3Status::StatusLine","R3Status/StatusLine.html#method-i-run","()","<p>Starts the operation of the status line and the output of the data to the\nstandard output.\n"],["state","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-state","()","<p>When implemented in derived class, returns the current state of the block,\nif available.\n"],["state","R3Status::Blocks::Clock","R3Status/Blocks/Clock.html#method-i-state","()","<p>Returns the current state of the block\n"],["state","R3Status::Blocks::KeyboardLayout","R3Status/Blocks/KeyboardLayout.html#method-i-state","()","<p>Returns the current state of the block.\n"],["state","R3Status::Blocks::Power","R3Status/Blocks/Power.html#method-i-state","()","<p>Returns the current state of the block\n"],["state","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-i-state","()","<p>Returns the current state of the block\n"],["terminate","R3Status::Blocks::Async","R3Status/Blocks/Async.html#method-i-terminate","()","<p>Signals the block to release any resources.\n"],["terminate","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-terminate","()","<p>Signals the block to release any resources.\n"],["to_hash","R3Status::Blocks::Memory","R3Status/Blocks/Memory.html#method-i-to_hash","(obj)",""],["to_s","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-to_s","(prefix: nil, postfix: nil)","<p>Returns the string representation of this block.\n<p>prefix &mdash; \n"],["toggle_mute","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-i-toggle_mute","()","<p>Toggles the mute state of the system volume.\n"],["update","R3Status::Blocks::Async","R3Status/Blocks/Async.html#method-i-update","()","<p>When first called, starts the update loop. Ignored afterwards.\n"],["update","R3Status::Blocks::Base","R3Status/Blocks/Base.html#method-i-update","()","<p>When implemented in derived classes, updates the text and color of this\nblock. Implmentations should …\n"],["update","R3Status::Blocks::Clock","R3Status/Blocks/Clock.html#method-i-update","()","<p>Updates the text and color of this block.\n"],["update","R3Status::Blocks::KeyboardLayout","R3Status/Blocks/KeyboardLayout.html#method-i-update","()","<p>Updates the text and color of this block.\n"],["update","R3Status::Blocks::Memory","R3Status/Blocks/Memory.html#method-i-update","()",""],["update","R3Status::Blocks::Power","R3Status/Blocks/Power.html#method-i-update","()","<p>Updates the text and color of this block.\n"],["update","R3Status::Blocks::Shell","R3Status/Blocks/Shell.html#method-i-update","()",""],["update","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-i-update","()","<p>Updates the text and color of this block.\n"],["volume","R3Status::Blocks::Volume","R3Status/Blocks/Volume.html#method-i-volume","()","<p>Returns the current system volume.\n"],["r3status.gemspec","","r3status_gemspec.html","","<p>Gem::Specification.new do |s|\n\n<pre>s.name        = &#39;r3status&#39;\ns.version     = &#39;0.1.2&#39;\ns.licenses    = [&#39;LGPL3&#39;] ...</pre>\n"],["readme","","readme_md.html","","<p>R3Status\n<p>Introduction\n<p>R3Status is replacement to i3&#39;s <code>i3status</code>. Written in ruby,\nit has compatability …\n"]]}}