require 'json'

class MessageType
  ACK=1
  ERROR=2
  COMMAND=3
end
class Message

  attr_reader :type
  attr_reader :data

  def initialize(type, data)
    @type = type
    @data = data
  end

  def dump
    return JSON.dump({
      'type' => @type,
      'data' => @data
    })
  end

  def self.load(json)
    begin 
      hash = JSON.parse(json)
      return Message.new(hash['type'], hash['data'])
    rescue JSON::ParserError
      return nil
    end
  end
end
