require 'json'

class MessageType
  ACK=1
  ERROR=2
  COMMAND=3
end
class Message
  def initialize(type, data)
    @type = type
    @data = data
  end

  def get_type
    @type
  end

  def get_data
    @data
  end

  def to_json
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
      return false
    end
  end
end
