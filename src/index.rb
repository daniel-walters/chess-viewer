require_relative "game"
require_relative "file_reader"
require_relative "display"

game = Game.new
reader = FileReader.new("bobby.pgn")
draw_board(game.cur_board)
move_info = reader.get_move("#{game.turn}#{game.player_to_move}")
game.cur_board.move_piece(move_info)
sleep(1)
draw_board(game.cur_board)


