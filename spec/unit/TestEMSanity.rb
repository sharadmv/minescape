require 'rspec'
require 'em-rspec'
require './lib/GameServer.rb'

describe GameServer do
  before do
    @gs = GameServer.new(9090)
<<<<<<< HEAD
    @gs.start
  end
  it 'should be running' do
    @gs.isRunning.should(be_true)
=======
    @gs.start()
  end
  it 'should be running' do
    @gs.isRunning().should be_true
>>>>>>> added in new testing framework
  end
end
