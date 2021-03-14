# simple_routing

```ruby
require_relative "./lib/simple_routing"

rt = SimpleRouting::RouteHandler.new
# rt.show_routes
rt.each_route do |route|
  route.show
end
```

```ruby
 % ruby test.rb                                                                                                                                        (git)-[main] 
family: 2, dst_len: 0, src_len: 0, tos: 0, table: 254, protocol: 3, scope: 0, type: 1, flags: 0
  type: RTA_TABLE, data: 254
  type: RTA_GATEWAY, data: 172.31.0.1
  type: RTA_OIF, data: eth0
family: 2, dst_len: 0, src_len: 0, tos: 0, table: 254, protocol: 3, scope: 0, type: 1, flags: 0
  type: RTA_TABLE, data: 254
  type: RTA_PRIORITY, data: 10001
  type: RTA_GATEWAY, data: 172.31.0.1
  type: RTA_OIF, data: eth1
family: 2, dst_len: 0, src_len: 0, tos: 0, table: 254, protocol: 3, scope: 0, type: 1, flags: 0
  type: RTA_TABLE, data: 254
  type: RTA_PRIORITY, data: 10002
  type: RTA_GATEWAY, data: 172.31.0.1
  type: RTA_OIF, data: eth2
```
