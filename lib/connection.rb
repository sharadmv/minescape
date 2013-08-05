require 'json'

require './lib/message'
require './lib/handler/command'
require './lib/model/player'

class Connection

  @@HANDLERS = {
    MessageType::COMMAND => CommandHandler
  }

  def initialize(ws)
    @ws = ws

    @ws.onopen do |handshake|
      response = Message.new(MessageType::ACK, {
        "message" => "Connection established"
      })
      ws.send(response.dump)
    end

    @ws.onclose do 
    end

    @ws.onmessage do |raw_msg|
      message = Message.load(raw_msg)
      if message.nil?
        error("Malformed message")
        next
      end
      @@HANDLERS[message.type].new(self, message).handle
    end
  end

  def error(msg)
    err = Message.new(MessageType::ERROR, {
      "message" => msg
    })
    @ws.send(err.dump)
  end

  def ack(msg)
    ack = Message.new(MessageType::ACK, {
      'message' => msg
    })
    @ws.send(ack.dump)
  end

  def send(message)
    @ws.send(message.dump)
  end
end
