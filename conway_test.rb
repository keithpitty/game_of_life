require 'test/unit'
require_relative 'conway'

class ConwayTest < Test::Unit::TestCase
  
  def setup
    @game = Conway.new
  end
  
  def test_get_cell_by_coord
    initial_state = [
      [false, false, false],
      [false, true, false],
      [false, false, false]
    ]
    @game.state = initial_state
    assert !@game.alive?(0,0)
    assert !@game.alive?(0,1)
    assert !@game.alive?(0,2)
    assert !@game.alive?(1,0)
    assert @game.alive?(1,1)
    assert !@game.alive?(1,2)
    assert !@game.alive?(2,0)
    assert !@game.alive?(2,1)
    assert !@game.alive?(2,2)
    assert @game.alive?(4,4)
  end
  
  def test_rule_1
    initial_state = [
      [false, false, false],
      [false, true, false],
      [false, false, false]
    ]
    expected_state = [
      [false, false, false],
      [false, false, false],
      [false, false, false]
    ]
    @game.state = initial_state
    actual_state = @game.next_state
    assert_equal(expected_state, actual_state)
  end

  def test_rule_2
    initial_state = [
      [false, false, false, false],
      [false, true, true, false],
      [false, true, true, true],
      [false, false, false, false]
    ]
    expected_state = [
      [false, false, false, false],
      [false, true, false, false],
      [false, true, false, true],
      [false, false, false, false]
    ]
    @game.state = initial_state
    actual_state = @game.alive_after_rule? {|x,y| @game.alive_after_rule_2?(x,y) }
    assert_equal(expected_state, actual_state)
  end
  
  def test_rule_3
    initial_state = [
      [false, false, false, false],
      [false, true, true, false],
      [false, true, true, true],
      [false, false, false, false]
    ]
    expected_state = [
      [false, false, false, false],
      [false, true, false, false],
      [false, true, false, true],
      [false, false, false, false]
    ]
    @game.state = initial_state
    actual_state = @game.alive_after_rule? {|x,y| @game.alive_after_rule_3?(x,y) }
    assert_equal(expected_state, actual_state)
  end

  def test_rule_4
      initial_state = [
        [false, false, false, false],
        [false, false, false, false],
        [false, true, true, true],
        [false, false, false, false]
      ]
      expected_state = [
         [false, false, false, false],
          [false, false, true, false],
          [false, false, false, false],
          [false, false, true, false]
      ]
      @game.state = initial_state
      actual_state = @game.alive_after_rule? {|x,y| @game.alive_after_rule_4?(x,y) }
      assert_equal(expected_state, actual_state)
  end
  
end