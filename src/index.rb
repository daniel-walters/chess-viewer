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
            begin
                if (ARGV[i+1]).to_i <= 0 then raise ArgumentError.new("Time must be greater than 0, using default(3)") end
                args_to_pass.push(ARGV[i+1].to_i)   
            rescue ArgumentError => e
                puts e.message
                sleep(2)
                args_to_pass.push(3)
            end      
        end
        if arg == "-p" || arg == "--path"
            path = ARGV[i+1]
        end
    end

    if !ARGV.include?("-p") && !ARGV.include?("--path") then path = "pgn/FischerVsThomason.pgn" end
else
    path = "pgn/FischerVsThomason.pgn"
end

ARGV.clear

#Load File and get JSON
reader = FileReader.new(path)
data = reader.data

#Create Game with arguments
args_to_pass.unshift(data)
game = Game.new(*args_to_pass)

#Main menu selection
case Display.menu
when 1
    game.play_full_game
when 2
    game.play_manual
when 3
    exit
end

