# 12Byte
module SimpleRouting
  class Rtmsg
    attr_accessor :family, :dst_len, :src_len, :tos, :table, :protocol, :scope, :type, :flags

    RTPROT_UNSPEC = 0
    RTPROT_REDIRECT = 1
    RTPROT_KERNEL = 2
    RTPROT_BOOT = 3
    RTPROT_STATIC = 4

    def initialize(data)
      @family = data[0].to_i_from_hex
      @dst_len = data[1].to_i_from_hex
      @src_len = data[2].to_i_from_hex
      @tos = data[3].to_i_from_hex
      @table = data[4].to_i_from_hex
      @protocol = data[5].to_i_from_hex
      @scope = data[6].to_i_from_hex
      @type = data[7].to_i_from_hex
      @flags = data[8, 4].to_i_from_hex
    end
  end
end
