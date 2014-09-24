require_relative './r3status/blocks.rb'
require 'json'

module R3Status
  def loop_with_interval secs
    loop do
      start = Time.now
      yield
      interval = secs - (Time.now - start)
      sleep(interval) if interval > 0
    end
  end

  class StatusLine
    attr_reader :blocks, :prefix, :postfix, :update_interval
    
    def initialize(prefix: " ", postfix: nil, update_interval: 0.4)
      @blocks = []
      @prefix = prefix
      @postfix = postfix
      @update_interval = update_interval
    end
    
    def << block
      @blocks << block
    end
    
    def transmission
      @blocks.map { |i| i.to_s(postfix: @postfix, prefix: @prefix) }.
              reject { |i| i.nil? }.inject { |i, j| i << ",#{j}"}
    end
    def parse str
      return if str.length < 2
      obj = nil
      
      str = str.sub(/\A\,/ , "")
      File.open("input.txt", 'a') {|f| f.puts str }
      begin
        obj = JSON.parse(str)
      rescue Exception => e
        File.open("log.txt", 'a') {|f| f.puts e.to_s }
        return
      end
      block = @blocks.find { |b| b.name == obj["name"] }
      block.clicked(obj["button"], obj["x"], obj["y"]) unless block.nil?
    end
    def run
    
      fork do
        loop do
          s = gets.chomp
          parse s
        end
      end
      
      puts "{\"version\":1, \"click_events\":true}["
      loop_with_interval(0.2) do
        @blocks.each {|b| b.update }
        puts "[#{transmission}],"
      end
    end
  end
end