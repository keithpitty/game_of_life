class Conway
  
  attr_accessor :state
  
  def alive?(x, y)
    @state[x % @state.size][y % @state[0].size]
  end
  
  def dead?(x, y)
    !alive?(x, y)
  end
  
  
  def next_state
    result = alive_after_rule? do |x,y|
      #alive_after_rule_1?(x, y) && alive_after_rule_2?(x,y) && alive_after_rule_3?(x,y) && alive_after_rule_4?(x,y)
      count = number_of_living_neighbours(x,y)
      alive = alive?(x,y)
      dead = !alive
      if alive && count < 2
        false
      elsif alive && [2,3].include?(count)
        true
      elsif alive && count > 3
        false
      elsif dead && count == 3
        true
      else
        false
      end
    end
    result
  end
  
  def advance_state
    @state = next_state
  end
  
  def alive_after_rule?
    raise "Fuck!" unless block_given?
    result = new_blank_state
    (0...@state.size).each do |x|
      (0...@state[0].size).each do |y|
        result[x][y] = yield(x,y)
      end
    end
    result
  end
  
  def height
    @state[0].size
  end
  
  def width
    @state.size
  end
  
  def to_s
    result = ""
    (0...height).each do |y|
      (0...width).each do |x|
        if alive?(x,y)
          result << '*'
        else
          result << ' '
        end
      end
      result << "\n"
    end
    result
  end
  
  private
  
  def new_blank_state
    result = []
    (0...@state.size).each do |x|
      result << []
      (0...@state[0].size).each do |y|
        result[x] << false
      end
    end
    result
  end
  
  def neighbours(x, y)
    [ alive?(x-1, y-1),
      alive?(x, y-1),
      alive?(x+1, y-1),
      alive?(x-1, y),
      alive?(x+1, y),
      alive?(x-1, y+1),
      alive?(x, y+1),
      alive?(x+1, y+1)
    ]
  end
  
  def alive_after_rule_1?(x, y)
    alive?(x,y) && number_of_living_neighbours(x, y) >= 2
  end

  def alive_after_rule_2?(x, y)
    alive?(x,y) && [2,3].include?(number_of_living_neighbours(x, y))
  end
  
  def alive_after_rule_3?(x, y)
    alive?(x,y) && number_of_living_neighbours(x, y) <= 3
  end
  
  def alive_after_rule_4?(x,y)
    dead?(x,y) && number_of_living_neighbours(x, y) == 3
  end
  
  def number_of_living_neighbours(x, y)
    neighbours(x, y).select{|c| c}.size
  end
  
end

if __FILE__ == $0
  @game = Conway.new
  initial_state = []
  (0...70).each do |x|
    initial_state << []
    (0...20).each do |y|
      initial_state[x] << (rand() < 0.1)
    end
  end
  @game.state = initial_state
  while true
    puts @game
    sleep 0.25
    @game.advance_state
  end
end