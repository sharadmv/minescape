require_relative './lib/game_server.rb'

server = GameServer.new(9090)
server.start()
