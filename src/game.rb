require_relative "board"
require_relative "piece"
require_relative "square"

cur_board = Board.new

cur_board.board[0][0].piece = Piece.new(:Pawn)
puts cur_board.board[0][0].to_s