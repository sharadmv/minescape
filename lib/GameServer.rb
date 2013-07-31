require 'em-websocket'

class GameServer
  def initialize(port)
    @port = port
    @running = false
  end

  def isRunning
    @running
  end

  def start
    EM.run do
      @running = true
      EM::WebSocket.run(:host => "localhost", :port => @port) do |ws|
        ws.onopen do |handshake|
          puts "WebSocket connection open"
          ws.send("Hello Client, you connected to #{handshake.path}")
        end

        ws.onclose { puts "Connection closed" }

        ws.onmessage do |raw_msg|
          puts "Recieved message: #{raw_msg}"

          begin
            msg = JSON.parse(raw_msg)
          rescue JSON::ParserError
            ws.send("Malformed json: #{raw_msg}")
            next
          end
          command = msg['command']

          object, method = command.split('.')

          case object
          when 'player'
            if !msg.include?('player_id')
              ws.send("Missing player_id")
              next
            end
            player_id = msg['player_id']
            player = Player[player_id]

            if player.nil?
              ws.send("Invalid player_id #{player_id}")
              next
            end

            if !Player.method_defined?(method.to_sym)
              ws.send("Invalid method #{method}")
              next
            end

            player.send(method.to_sym)
          else
            ws.send("Unknown object: #{object}")
            next
          end

          wn.send("Performed command: #{command}")
        end
      end
    end
  end
end
