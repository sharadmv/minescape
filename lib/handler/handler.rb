class Handler
  def initialize(conn, message)
    @conn = conn
    @message = message
  end

  def handle
    raise 'Not Implemented'
  end
end
