require_relative './lib/GameServer.rb'

server = GameServer.new(9090)
server.start()
