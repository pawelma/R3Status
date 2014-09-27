require_relative './r3status/blocks.rb'
require 'json'

module R3Status
  # Specifies the mouse buttons and their IDs.
  MOUSE_BUTTONS = {primary: 1, middle: 2, secondary: 3, scroll_up: 4, scroll_down: 5}
  
  # Loops over the given block at the specified interval.
  # The interval is the time between yields, not between a yield's ends the next's start.
  def loop_with_interval secs
    loop do
      start = Time.now
      yield
      interval = secs - (Time.now - start)
      sleep(interval) if interval > 0
    end
  end
  
  # This class encapsulates a status output.
  # Blocks are added by the user and are displayed each iteration.
  # ==== Example
  #   s = StatusLine.new
  #   s = StatusLine.new update_interval: 3
  #
  #   s << Blocks::Volume.new
  #   
  #   s.run
  class StatusLine
    # A list blocks to display, right to left, in the bar.
    attr_reader :blocks
    # An object (e.g. _String_) that will be inserted at the start of a block's text. Default: _" "_.
    attr_accessor :prefix
    # An object (e.g. _String_)that will be inserted at the ebd of a block's text. Default: _nil_.
    attr_accessor :postfix 
    # The time (in seconds) between iterations. Default: _0.4_.
    attr_accessor :update_interval
    
    # Creates a new StatusLine object.
    def initialize(prefix: " ", postfix: nil, update_interval: 0.4)
      @blocks = []
      @prefix = prefix
      @postfix = postfix
      @update_interval = update_interval
    end
    
    # Appends a new block to this StatusLine object.
    def << block
      @blocks << block
    end
    
    # Starts the operation of the status line and the output of the data to the standard output.
    def run
      @reader_thread = Thread.new do
        loop do
          s = gets.chomp
          parse s
        end
      end
      @reader_thread.run
      
      at_exit do
        @reader_thread.kill
        @blocks.each { |b| b.terminate }
      end
      
      puts "{\"version\":1, \"click_events\":true}["
      loop_with_interval(0.2) do
        @blocks.each {|b| b.update }
        puts "[#{transmission}],"
      end
      
    end
    
    private
    # Generates a single transmission.
    def transmission
      @blocks.map { |i| i.to_s(postfix: @postfix, prefix: 
      @prefix) }.
              reject { |i| i.nil? }.inject { |i, j| i << ",#{j}"}
    end
    
    # Parses a single input from i3bar.
    def parse(str)
      return if str.length < 2
      obj = nil
      str = str.strip.sub(/\A\,/ , "")
      
      begin
        obj = JSON.parse(str)
      rescue Exception => e
        return
      end
      
      block = @blocks.find { |b| b.name == obj["name"] }
      block.clicked(obj["button"], obj["x"], obj["y"]) unless block.nil?
    end
  end
end
