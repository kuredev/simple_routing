module SimpleRouting
  class Route
    attr_accessor :family, :dst_len, :src_len, :tos, :table, :protocol, :scope, :type, :flags, :rta_oif, :rta_table, :rta_dst, :rta_prefsrc
    def initialize(family:, dst_len:, src_len:, tos:, table:, protocol:, scope:, type:, flags:);
      @family = family
      @dst_len = dst_len
      @src_len = src_len
      @tos = tos
      @table = table
      @protocol = protocol
      @scope = scope
      @type = type
      @flags = flags
      @attrs = []
    end

    def add_rtattr(rtattr)
      @attrs.push(rtattr)
    end

    def show(filter_table: 254)
      not_show_flag = false
      not_show_flag = true if table != filter_table

      str = "family: #{family}, dst_len: #{dst_len}, src_len: #{src_len}, tos: #{tos}, table: #{table}, protocol: #{protocol}, scope: #{scope}, type: #{type}, flags: #{flags}\n"
      @attrs.each do |attr|
        not_show_flag = true if attr.rta_type == "RTA_TABLE" && attr.rta_data != 254
        str += "  type: #{attr.rta_type}, data: #{attr.rta_data}\n"
      end

      puts str unless not_show_flag
    end

    # TODO: Implement...
    # show like `ip route`
    def show_like_ip
      return if table != 254

      str = ""
      if dst_len == 0
        str = "default via #{extract_gateway_address_from_attrs} dev #{extract_oif_from_attrs}"
      elsif dst_len == 32
        str = "#{extract_dst_from_attrs} dev #{extract_oif_from_attrs}"
      else
      end

      puts str unless str == ""
    end

    private

    def extract_dst_from_attrs
      attr = @attrs.find { |attr| attr.rta_type_dst? }
      attr&.rta_data
    end

    def extract_gateway_address_from_attrs
      attr = @attrs.find { |attr| attr.rta_type_gateway? }
      attr&.rta_data
    end

    def extract_oif_from_attrs
      attr = @attrs.find { |attr| attr.rta_type_oif? }
      attr&.rta_data
    end
  end
end

