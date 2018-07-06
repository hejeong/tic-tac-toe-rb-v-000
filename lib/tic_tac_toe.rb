WIN_COMBINATIONS = [
  [0,1,2], # top-row  
  [3,4,5], # middle-row
  [6,7,8], # bottom-row
  [0,3,6], # left-column
  [1,4,7], # middle-column
  [2,5,8], # right-column
  [0,4,8], # back-diagonal
  [2,4,6]  # forward-diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, position, token)
  board[position] = token
end

def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    true
  else
    false
  end
end

def valid_move?(board,position)
  if !position_taken?(board,position) && position.between?(0,8)
    true
  else 
    false
  end
end

def turn(board)
  puts "Enter a valid position(1-9): "
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  
  if valid_move?(board,index)
    move(board, index, token)
  else
    until valid_move?(board,index)
      puts "Enter a valid position(1-9): "
      input = gets.strip
      index = input_to_index(input)
    end
    move(board, index, token)
  end 
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |element|
    if element == "X" || element == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end

# board = ["O", " ", "X", "O", "O", "X", "O", "X" , "X" ]
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    # combo = [3, 4, 5]
    first_index = combo[0]     #first_index = 3 
    second_index = combo[1]    #second_index = 4
    third_index = combo[2]     #third_index = 5
    
    if board[first_index] == "X" && board[second_index] == "X" && board[third_index] == "X"
      return true
    elsif board[first_index] == "O" && board[second_index] == "O" && board[third_index] == "O"
      return true
    else 
      return nil
    end
  end
end

def full?(board)
  board.none? do |element|
    if element != "X" && element != "O"
      true
    end
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if full?(board) || won?(board) || draw?(board)
    true
  else
    false
  end
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo.class != Array
    nil
  else
    winning_index = winning_combo[0]
    winning_token = board[winning_index]
  end
end

def play(board)
  display_board(board)
  until over?(board)
    turn(board)
  end
  
  if draw?(board)
    puts "Cat's Game!"
  else
    winner = winner(board)
    puts "Congratulations #{winner}!"  
  end
end