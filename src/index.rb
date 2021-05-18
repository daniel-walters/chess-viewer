require_relative "game"
require_relative "file_reader"
require_relative "display"

reader = FileReader.new("bobby.pgn")
white = reader.data["game_tags"]["White"]
black = reader.data["game_tags"]["Black"]
game = Game.new(white, black)
draw_board(game.cur_board)
move_info = reader.get_move("#{game.turn}#{game.player_to_move}")
game.cur_board.move_piece(move_info)
sleep(1)
draw_board(game.cur_board)
puts "#{game.player_white} vs. #{game.player_black}"

