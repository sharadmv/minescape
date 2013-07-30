require 'test/unit'
require 'fiber'
require 'em-test'

class EmTestHelperTest < Test::Unit::TestCase
  include EventMachine::TestHelper

  def test_trivial
    em do
      assert_equal 1, 1
      done
    end
  end
  def test_timer
    em do
      start = Time.now
      EM.add_timer(0.5){
        assert_in_delta 0.5, Time.now-start, 0.1
        done
      }
    end
  end

end
