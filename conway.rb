class Conway
  
  attr_accessor :state
  
  def cell_at(x, y)
    @state[x % @state.size][y % @state[0].size]
  end
  
  def next_state
    result = new_blank_state
    (0...@state.size).each do |x|
      (0...@state[0].size).each do |y|
        result[x][y] = surrounding_cells(x, y).any? && cell_at(x,y)
      end
    end
    result
  end
  
  def new_blank_state
    [[false, false, false],
    [false, false, false],
    [false, false, false]]
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
  
end