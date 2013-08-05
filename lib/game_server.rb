require 'em-websocket'
require 'json'
require_relative './util'
require_relative './connection'

class GameServer
  def initialize(port)
    @port = port
    @running = false
  end

  def is_running
    @running
  end

  def start
    EM.run do
      @running = true
      EM::WebSocket.run(:host => "localhost", :port => @port) do |ws|
        Connection.new(ws)
      end
    end
  end
end
