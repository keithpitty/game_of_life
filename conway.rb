class Conway
  
  attr_accessor :state
  
  def cell_at(x, y)
    @state[x % @state.size][y % @state[0].size]
  end
  
  def next_state
    result = new_blank_state
    (0...@state.size).each do |x|
      (0...@state[0].size).each do |y|
        result[x][y] = apply_rule_1(x, y) && apply_rule_3(x,y)
      end
    end
    result
  end
  
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
  
  def surrounding_cells(x, y)
    [ cell_at(x-1, y-1),
      cell_at(x, y-1),
      cell_at(x+1, y-1),
      cell_at(x-1, y),
      cell_at(x+1, y),
      cell_at(x-1, y+1),
      cell_at(x, y+1),
      cell_at(x+1, y+1)
    ]
  end
  
  def apply_rule_1(x, y)
    cell_at(x,y) && surrounding_cells(x, y).select{|c| c}.size >= 2
  end
  
  def apply_rule_3(x, y)
    cell_at(x,y) && !(surrounding_cells(x, y).select{|c| c}.size > 3)
  end
  
end