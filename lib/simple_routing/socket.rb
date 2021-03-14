require "socket"

class Socket
  PF_NETLINK = 16 unless defined? Socket::PF_NETLINK
  AF_NETLINK = PF_NETLINK unless defined? Socket::AF_NETLINK
end
