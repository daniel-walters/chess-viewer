require_relative "board"
require_relative "piece"
require_relative "square"
require_relative "file_reader"
require_relative "display"

require "egd"
require "json"

cur_board = Board.new

reader = FileReader.new("bobby.pgn")

data = reader.data

draw_board(cur_board.board)