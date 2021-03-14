module SimpleRouting
  class Rtattr
    attr_accessor :len, :type

    RTA_DST = 1
    RTA_OIF = 4
    RTA_GATEWAY = 5
    RTA_PRIORITY = 6
    RTA_PREFSRC = 7
    RTA_TABLE = 15

    def initialize(rtattr)
      @len = rtattr[0, 2].to_i_from_hex
      @type = rtattr[2, 2].to_i_from_hex
    end

    def add_data(data)
      @data = data
    end

    def rta_type
      case type
      when RTA_DST
        "RTA_DST"
      when RTA_OIF
        "RTA_OIF"
      when RTA_GATEWAY
        "RTA_GATEWAY"
      when RTA_PRIORITY
        "RTA_PRIORITY"
      when RTA_PREFSRC
        "RTA_PREFSRC"
      when RTA_TABLE
        "RTA_TABLE"
      else
        "Unknown RTA TYPE:#{@type.to_i_from_hex}"
      end
    end

    def rta_type_dst?
      type == RTA_DST
    end

    def rta_type_gateway?
      type == RTA_GATEWAY
    end

    def rta_type_oif?
      type == RTA_OIF
    end

    def rta_data
      case type
      when RTA_DST
        IPAddr.new_ntoh(@data)
      when RTA_OIF
        if_index_to_name(@data.to_i_from_hex)
      when RTA_GATEWAY
        IPAddr.new_ntoh(@data)
      when RTA_PRIORITY
        @data.to_i_from_hex
      when RTA_PREFSRC
        IPAddr.new_ntoh(@data)
      when RTA_TABLE
        @data.to_i_from_hex
      else
        "Unknown RTA TYPE DATA"
      end
    end

    def if_index_to_name(index)
      Socket.getifaddrs.find do |ifaddr|
        ifaddr.ifindex == index
      end&.name
    end
  end
end

