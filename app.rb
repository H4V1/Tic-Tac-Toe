class Player
  def initialize(moves, move)
    @move = move
    @moves = moves
  end

  def check_move
    until @moves.last != @move
      puts 'Please enter a different move'
      @move = gets.chomp.to_i
    end
  end

  def move_return
    @move
  end
end

class Grid
  def initialize(moves)
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @turns = ''
    @moves = moves
  end

  def draw_grid
    @cells.map! { |cell| cell == @moves.last ? 'X' : cell }
    @turns = 'X'
    puts "|#{@cells[0]}| |#{@cells[1]}| |#{@cells[2]}|"
    puts "|#{@cells[3]}| |#{@cells[4]}| |#{@cells[5]}|"
    puts "|#{@cells[6]}| |#{@cells[7]}| |#{@cells[8]}|"
  end

  def update_grid
    @cells.each do |cell|
      if cell == @moves.last && @turns == 'X'
        @cells[@cells.index(cell)] = 'O' && @turns = 'O'
      elsif cell == @moves.last && @turns == 'O'
        @cells[@cells.index(cell)] = 'X' && @turns = 'X'
      end
    end
    puts "|#{@cells[0]}| |#{@cells[1]}| |#{@cells[2]}|"
    puts "|#{@cells[3]}| |#{@cells[4]}| |#{@cells[5]}|"
    puts "|#{@cells[6]}| |#{@cells[7]}| |#{@cells[8]}|"
  end

  def check_combinations
    @winner_combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3 ,6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @winner_combinations.each do |comb|
      if @moves.length == 9
        return 0
      elsif comb.all? { |i| @cells[i] == 'X' } || comb.all? { |i| @cells[i] == 'O' }
        return 1
      end
    end
  end
end

moves_history = []
# GAMES START
puts 'please enter your move'
player1 = Player.new(moves_history, gets.chomp.to_i)
moves_history.push(player1.move_return)
grid = Grid.new(moves_history)
grid.draw_grid

puts 'please enter your move'
player2 = Player.new(moves_history, gets.chomp.to_i)
player2.check_move
moves_history.push(player2.move_return)
grid.update_grid


7.times do
  puts 'please enter your move'
  player1 = Player.new(moves_history, gets.chomp.to_i)
  player1.check_move
  moves_history.push(player1.move_return)
  grid.update_grid

  case grid.check_combinations
  when 1
    puts 'We have a winner'
    break
  when 0
    puts "It's a tie"
    break
  end

  puts 'please enter your move'
  player2 = Player.new(moves_history, gets.chomp.to_i)
  player2.check_move
  moves_history.push(player2.move_return)
  grid.update_grid

  case grid.check_combinations
  when 1
    puts 'We have a winner'
    break
  when 0
    puts "It's a tie"
    break
  end
end
