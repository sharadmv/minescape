require'json'
require_relative './message'
require_relative './model/player'

class Connection
  def initialize(ws)
    @ws = ws

    @ws.onopen do |handshake|
      response = Message.new(MessageType::ACK, {
        "message" => "Connection established"
      })
      ws.send(response.to_json)
    end

    @ws.onclose do 
    end

    @ws.onmessage do |message|
      msg = Message.load(message)
      if not msg
        send_error("Malformed message")
        next
      end
      if msg.get_type == MessageType::COMMAND
        data = msg.get_data
        command = data['command']
        object, method = command.split('.')
        case object
        when 'player'
          if !data.include?('player_id')
            send_error("Missing player_id")
            next
          end
          player_id = data['player_id']
          player = Player[player_id]
          
          if player.nil?
            send_error("Invalid player_id #{player_id}")
            next
          end

          if !Player.method_defined?(method.to_sym)
            send_error("Invalid method #{method}")
            next
          end

          player.send(method.to_sym)
        else
          send_error("Unknown object: #{object}")
          next
        end
      end
      response = Message.new(MessageType::ACK, {
        "message" => "Message received"
      })
      ws.send(response.to_json)
    end
  end

  def send_error(msg)
    err = Message.new(MessageType::ERROR, {
      "message" => msg
    })
    @ws.send(err.to_json)
  end

  def send(message)
    @ws.send(message.to_json)
  end
end
