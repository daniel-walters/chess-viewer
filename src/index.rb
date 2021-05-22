require_relative "game"
require_relative "file_reader"
require_relative "display"

args_to_pass = []
path = ""
####ARGUMENT HANDLING#####
if ARGV.length > 0
    
    case
    when ARGV.include?("-h") || ARGV.include?("--help")
        Display.help_message
        exit
    when ARGV.include?("-i") || ARGV.include?("--info")
        Display.info_message
        exit
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
ARGV.clear

reader = FileReader.new(path)
data = reader.data


args_to_pass.unshift(data)
game = Game.new(*args_to_pass)

case Display.menu
when 1
    game.play_full_game
when 2
    game.play_manual
when 3
        exit
end

