require_relative "game"
require_relative "file_reader"
require_relative "display"

reader = FileReader.new("ep_eg.pgn")
data = reader.data
game = Game.new(data)
draw_board(game.cur_board)
sleep(1)
game.play_full_game
puts "#{game.player_white} vs. #{game.player_black}"
