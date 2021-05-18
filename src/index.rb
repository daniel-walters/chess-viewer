require_relative "game"
require_relative "file_reader"
require_relative "display"

reader = FileReader.new("bobby.pgn")
data = reader.data
game = Game.new(data)
draw_board(game.cur_board)
game.play_turn
sleep(1)
draw_board(game.cur_board)
puts "#{game.player_white} vs. #{game.player_black}"
