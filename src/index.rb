require_relative "game"
require_relative "file_reader"
require_relative "display"

args_to_pass = []
path = ""
####ARGUMENT HANDLING#####
#lets user type arguments in any order they want in the format:
#ruby index.rb -t <time> -p <path>
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
            begin
                if (!ARGV[i+1]) then raise ArgumentError.new("No Path detected, loading default") end
                path = ARGV[i+1]
            rescue ArgumentError => e
                puts e.message
                sleep(2)
                path = "pgn/FischerVsThomason.pgn"
            end
        end
    end

    if !ARGV.include?("-p") && !ARGV.include?("--path") then path = "pgn/FischerVsThomason.pgn" end
else
    path = "pgn/FischerVsThomason.pgn"
end

ARGV.clear

#Load File and get JSON
#if file doesnt exist or not in pgn format then load default file
begin
    reader = FileReader.new(path)
    data = reader.data
rescue
    puts "File not found or invalid format. Loading default game"
    path = "pgn/FischerVsThomason.pgn"
    sleep(2)
    retry
end

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

