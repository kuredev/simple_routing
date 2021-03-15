require "ipaddr"

module SimpleRouting
  class RouteHandler
    NETLINK_ROUTE = 0
    RTM_GETADDR = 22
    RTM_GETROUTE = 26 # /usr/include/linux/rtnetlink.h
    NLM_F_REQUEST = 1
    NLM_F_ROOT = 0x100

    def socket
      @socket ||= Socket.new(Socket::AF_NETLINK, Socket::SOCK_RAW, NETLINK_ROUTE)
    end

    def show_routes
      routes = fetch_routes
      routes.each do |route|
        route.show
      end
    end

    # TODO: Implement
    def show_route_like_ip
    end

    def each_route(&block)
      routes = fetch_routes
      routes.each do |route|
        yield route
      end
    end

    private

    def build_route_from_rtmsg(rtmsg)
      Route.new(
        family: rtmsg.family,
        dst_len: rtmsg.dst_len,
        src_len: rtmsg.src_len,
        tos: rtmsg.tos,
        table: rtmsg.table,
        protocol: rtmsg.protocol,
        scope: rtmsg.scope,
        type: rtmsg.type,
        flags: rtmsg.flags
      )
    end

    def fetch_routes
      resp = request_and_recv
      resp_len = 1
      routes = []
      while resp_len > 0
        nlmshdhr = Nlmshdhr.new(resp.slice!(0, 16))

        rtmsg = Rtmsg.new(resp.slice!(0, 12))
        route = build_route_from_rtmsg(rtmsg)

        rtattr_all_len = nlmshdhr.len - 28

        while rtattr_all_len > 0
          rtattr = Rtattr.new(resp.slice!(0, 4))
          rtattr.add_data(resp.slice!(0, rtattr.len.to_i - 4))
          route.add_rtattr(rtattr)

          rtattr_all_len -= rtattr.len.to_i
        end
        routes.push(route)
        resp_len = resp.length
      end
      routes
    end

    def request_and_recv
      hdr = [24, RTM_GETROUTE, NLM_F_REQUEST | NLM_F_ROOT, 0, 0].pack('ISSII')
      ifa = [Socket::AF_INET, 0, 0, 0, 0, 0, 0, 0, 0].pack('CCCCI')
      socket.send(hdr + ifa, 0)
      socket.recv(4096)
    end
  end
end

