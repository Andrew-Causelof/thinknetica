require_relative './station.rb'
require_relative './route.rb'
require_relative './train.rb'

moscow = Station.new('Moscow');
balashikha = Station.new('balashikha');
route = Route.new(moscow, balashikha);
first = Train.new(1);
first.setup_route(route);
