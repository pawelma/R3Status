require 'vmstat'
module R3Status::Blocks
  # A block that displays the system's memory consumption
  #
  # ==== States
  #   :low, :normal, :high
  #
  # ==== Format values
  # * <tt>%{val}</tt>, <tt>%{consumption}</tt>: Disk consumption (in precentage,  without a percent sign).
  # * <tt>%{available_blocks}</tt>: The number of available blocks in the file system.
  # * <tt>%{free_blocks}</tt>: The number of free blocks in the file system.
  # * <tt>%{used_blocks}</tt>: The number of used blocks in the file system.
  # * <tt>%{total_blocks}</tt>: The total number blocks in the file system.
  # * <tt>%{available_bytes}</tt>: The number of available bytes in the file system.
  # * <tt>%{free_bytes}</tt>: The number of free bytes in the file system.
  # * <tt>%{used_bytes}</tt>: The number of used bytes in the file system.
  # * <tt>%{total_bytes}</tt>: The total number of bytes in the file system.
  # * <tt>%{block_size}</tt>: The size of the file-system's blocks in bytes.
  # * <tt>%{mount_point}</tt>: The mount point of the file system. (e.g. +/mnt/a+)
  # * <tt>%{type}</tt>: The file system type. (e.g. +:ext4+, +:ntfs+)
  
  class Disk < Base
    # Determines the memory consumption that will be considered low.
    attr_accessor :low_threshold 
    # Determines the memory consumption that will be considered high.
    attr_accessor :high_threshold
    # The number of figures after the decimal point.
    attr_accessor :figures
    # The path of the disk
    attr_accessor :path
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {low_threshold: 20, high_threshold: 90, path: '/',
              figures: 0, format: '\"%{mount_point}\": %{val}%'}.merge(args)
      super(args, &block)
    end
    
    # Updates the text and color of this block.
    def update
      @disk = disk = Vmstat.disk(path)
      s = state
      @full_text = formats[s] % {
              val: consumption, consumption: consumption, 
              free_blocks: disk.free_blocks, used: used_blocks, 
              available_blocks: disk.available_blocks, type: disk.type,
              total_blocks: disk.total_blocks, mount_point: disk.mount,
              block_size: disk.block_size, available_bytes: disk.available_bytes, 
              free_bytes: disk.free_bytes, used_bytes: disk.used_bytes,
              total_bytes: disk.total_bytes
      }                           
    end
    
    # Returns the current state of the block
    def state
      if consumption <  low_threshold
        :low
      elsif consumption > high_threshold
        :high
      else
        :normal
      end
    end
    
    # Returns the memory consumption in percents.
    def consumption
      (100 * used_blocks / @disk.total_blocks.to_f).round(figures)
    end
    
    def used_blocks
      @disk.used_bytes / @disk.block_size
    end
  end
end

