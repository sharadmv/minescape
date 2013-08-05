require './lib/handler/handler'
require './lib/model/player'

class CommandHandler < Handler
  def handle
    data = @message.data
    command = data['command']
    object, method = command.split('.')
    case object
    when 'player'
      if !data.include?('player_id')
        @conn.error('Missing player_id')
        return
      end
      player_id = data['player_id']
      player = Player[player_id]
      
      if player.nil?
        @conn.error("Invalid player_id #{player_id}")
        return
      end

      if !Player.method_defined?(method.to_sym)
        @conn.error("Invalid method #{method}")
        return
      end

      player.send(method.to_sym)
    else
      @conn.error("Unknown object: #{object}")
      return
    end
    @conn.ack('Command received')
  end
end
