require 'rspec'
require 'em-rspec'
require './lib/game_server.rb'

describe GameServer do
  before do
    @gs = GameServer.new(9090)
    @gs.start
  end
  it 'should be running' do
    @gs.is_running.should(be_true)
  end
end
