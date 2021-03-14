# 16Byte
module SimpleRouting
  class Nlmshdhr
    attr_reader :type, :flags, :seq, :pid

    def initialize(data)
      @len = data[0, 4]
      @type = data[4, 2]
      @flags = data[6, 2]
      @seq = data[8, 4]
      @pid = data[12, 4]
    end

    def len
      @len.to_i_from_hex
    end

    def flags
      @flags.to_i_from_hex
    end
  end
end
