require 'em-websocket'

EM.run do
  port = 9091
  puts "Starting websocket server"
  EM::WebSocket.run(:host => "0.0.0.0", :port => port) do |ws|
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
