require_relative "board"
require_relative "piece"
require_relative "square"
require_relative "file_reader"

require "egd"
require "json"

cur_board = Board.new

puts cur_board.board[0][0].to_s

reader = FileReader.new("bobby.pgn")

data = reader.data

pp reader.get_board_array(reader.get_FEN("1w"))