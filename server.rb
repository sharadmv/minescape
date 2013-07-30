require 'em-websocket'
require 'json'

EM.run do
  port = 9091
  puts "Starting websocket server"
  EM::WebSocket.run(:host => "0.0.0.0", :port => port) do |ws|
    ws.onopen do |handshake|
      puts "WebSocket connection open"
      ws.send("Hello Client, you connected to #{handshake.path}")
    end

    ws.onclose { puts "Connection closed" }

    ws.onmessage do |raw_msg|
      puts "Recieved message: #{raw_msg}"

      msg = JSON.parse(msg)
      command = msg['command']
      player_id = msg['player_id']

      player = Player[player_id] if player_id

      case command
      when 'player.forward_start'
        player.forward_start unless player
      when 'player.forward_stop'
        player.forward_stop unless player
      when 'player.backward_start'
        player.backward_start unless player
      when 'player.backward_stop'
        player.backward_stop unless player
      when 'player.strafe_left_start'
        player.strafe_left_start unless player
      when 'player.strafe_left_stop'
        player.strafe_left_stop unless player
      when 'player.strafe_right_start'
        player.strafe_right_start unless player
      when 'player.strafe_right_stop'
        player.strafe_right_stop unless player
      else
        ws.send("Unknown command: #{command}")
      end
      ws.send("Performed command: #{command}")
    end
  end
end
