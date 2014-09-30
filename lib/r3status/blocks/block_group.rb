module R3Status::Blocks
  # A block that groups other blocks.
  #
  # ==== States
  #   n/a
  #
  # ==== Format values
  #   n/a
  #
  # ==== Examples
  # group = GroupBlock.new(group_prefix: '{', group_postfix: '})
  # group << Volume.new
  # group << Battery.new
  # status_line << group
  class BlockGroup < Base
    # A list blocks to display, right to left, in the bar.
    attr_accessor :blocks
    # An object (e.g. #String) that will be inserted at the start of a block's text. Default: +" "+.
    attr_accessor :group_prefix
    # An object (e.g. #String)that will be inserted at the ebd of a block's text. Default: +nil+.
    attr_accessor :group_postfix
    
    # Creates a new instance of this class.
    # If a block is passed, it will be stored and yielded when the block is clicked.
    def initialize(**args, &block)
      args = {group_prefix: '[', group_postfix: ']'}.merge(args)
      super(args, &block)
      @name = nil
      @blocks ||= []
      @prefix_block = Base.new
      @postfix_block = Base.new
    end
    
    def <<(block)
      @blocks << block
    end
    
    # Updates the text and color of this block.
    def update
      @blocks.each {|b| b.update }
    end
    
    # Returns the string representation of this block.
    def to_s(prefix: nil, postfix: nil)
      @prefix_block.full_text = "#{prefix}#{group_prefix}"
      @postfix_block.full_text = "#{postfix}#{group_postfix}"
      
      [@prefix_block, blocks, @postfix_block].flatten.map(&:to_s)
                  .reject(&:nil?).inject {|i, j| i << ",#{j}" }
      
    end
  end
end
