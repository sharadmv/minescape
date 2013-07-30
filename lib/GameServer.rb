require 'em-websocket'

class GameServer
  def initialize(port)
    @port = port
    @running = false
  end

  def isRunning()
    @running
  end

  def start()
    EM.run do
      @running = true
      EM::WebSocket.run(:host => "localhost", :port => @port) do |ws|
        ws.onopen do |handshake|
          puts "WebSocket connection open"
          ws.send("Hello Client, you connected to #{handshake.path}")
        end

        ws.onclose { puts "Connection closed" }

        ws.onmessage do |msg|
          puts "Recieved message: #{msg}"
          ws.send("Pong: #{msg}")
        end
      end
    end
  end
end
