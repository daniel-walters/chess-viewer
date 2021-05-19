require_relative "game"
require_relative "file_reader"
require_relative "display"

args_to_pass = []
path = ""
####ARGUMENT HANDLING#####
if ARGV.length > 0
    
    case
    when ARGV.include?("-h") || ARGV.include?("--help")
        puts "help"
    when ARGV.include?("-i") || ARGV.include?("--info")
        puts "info"
    end

    ARGV.each_with_index do |arg, i|
        if arg == "-t" || arg == "--time"
            args_to_pass.push(ARGV[i+1].to_i)
        end
        if arg == "-p" || arg == "--path"
            path = ARGV[i+1]
        end
        
    end
end

reader = FileReader.new(path)
data = reader.data
args_to_pass.unshift(data)

game = Game.new(*args_to_pass)

draw_board(game.cur_board)
sleep(1)
game.play_full_game
puts "#{game.player_white} vs. #{game.player_black}"
