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

turn = 1
player_to_move = "w"

def change_turn(player_to_move)
    if player_to_move == "w"
        player_to_move = "b"
    else
        player_to_move = "w"
    end
end

move_info = reader.get_move("#{turn}#{player_to_move}")
cur_board.move_piece(move_info)
sleep(1)
draw_board(cur_board.board)



