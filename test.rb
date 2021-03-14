require_relative "./lib/simple_routing"

rt = SimpleRouting::RouteHandler.new
# rt.show_routes
rt.each_route do |route|
  route.show
end
