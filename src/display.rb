require "colorize"
require "artii"
require "os"
require_relative "input_error.rb"

class Display

    #navigates the board array and prints it out with alternating coloured squares
    def self.draw_board(board_obj, white, black)
        board = board_obj.board

        puts "#{white} (White) Vs. #{black} (Black)"
        print "\n"
        board.each_with_index do |row, row_i|
            print "#{8-row_i}"
            row.each_with_index do |square, square_i|
                if (row_i + square_i).odd?
                    print square.to_s.colorize(:background => :green)
                else
                    print square.to_s.colorize(:background => :light_black)
                end
            end
            print "\n"
        end
        puts "  a  b  c  d  e  f  g  h "
        print "\n"
    end

    #displays information on input move
    def self.move_info(cur_turn, cur_to_move, data)
        puts "Turn #{cur_turn}, #{cur_to_move == "w" ? "Whites" : "Blacks"} move"
        puts get_commentary(data, cur_to_move)
    end

    #UI to show before a game starts
    def self.game_start_ui
        puts "Starting Position"
        puts "Game Starting!"
        sleep(1)
        puts "3..."
        sleep(1)
        puts "2..."
        sleep(1)
        puts "1..."
        sleep(1)
        clear_screen
    end

    #UI to show after a game ends
    def self.game_end_ui(winner)
        puts "Final Position"
        puts "#{winner}"
    end
    
    #main menu. gets only valid input. returns seletion
    def self.menu
        a = Artii::Base.new
        clear_screen
        puts a.asciify("Chess Viewer")
        puts "-----------------------------------------------------------------"
        prompt = "\nChoose an option\n1) Automatic\n2) Manual\n3) Exit\n"
        print prompt
        
        begin
            input = gets.chomp.to_i
            raise InputError if input > 3 || input < 1
        rescue InputError => e
            clear_screen
            puts a.asciify("Chess Viewer")
            puts "-----------------------------------------------------------------"
            print prompt
            puts e.message
            retry
        end

        return input
    end

    #menu for manual mode. only accepts valid input, returns choice
    def self.man_menu
        valid_inputs = ["n", "b", "exit", "goto"]
        prompt = "\nType 'n' to go next, 'b' to go back, 'goto' to choose a move, or 'exit' to exit\n"
        print prompt
        
        begin
            input = gets.chomp.downcase
            raise InputError if !valid_inputs.include?(input)
        rescue InputError => e
            puts e.message
            retry
        end

        return input
    end

    #gets a move from the player
    def self.get_move
        puts "Enter a move to go to"
        puts "Move must be in the format <turn><player_color>. I.e. '5w' for turn 5, whites move"
        input = gets.chomp.downcase
    end

    #construts a commentary message about the move
    def self.get_commentary(move_info, player)
        com = ""
        player == "w" ? com += "White plays " : com += "Black plays "
        com += "#{piece_short_to_long(move_info[:piece])} from "
        com += "#{move_info[:from]} to #{move_info[:to]}."
        if move_info[:captured_piece] then com += " Capturing a #{piece_short_to_long(move_info[:captured_piece])}." end
        if move_info[:promote_to] then com += " Promoting to a #{piece_short_to_long(move_info[:promote_to])}." end
        if move_info[:check] then com += " Check!" end
        if move_info[:checkmate] then com += " Checkmate!" end

        return com
    end

    #takes shorthand chess piece and returns full name of piece
    def self.piece_short_to_long(piece)
        case piece.downcase 
        when "p"
            "Pawn"
        when "n"
            "Knight"
        when "bd", "bl"
            "Bishop"
        when "r"
            "Rook"
        when "q"
            "Queen"
        when "k"
            "King"
        end
    end

    #help message to display on -h or --help
    def self.help_message
        puts "Chess Viewer - Help"
        puts "Main Flags/Arguments:"
        puts "  -t <time in seconds> OR --time <time in seconds> -- Set time in seconds between each move (3s by default)"
        puts "  -p <filepath> OR --path <filepath> -- Set the path to the PGN file"
        puts "Informative Flags/Arguments:"
        puts "  -h OR --help -- Display this message"
        puts "  -i OR --info -- Display Information on the Program"
        puts "For more info please refer to the README.md"
    end

    #info message to display on -i or --info
    def self.info_message
        puts "Program: Chess Viewer"
        puts "by Daniel Walters"
        puts "\nDownload any PGN file from the internet and Chess Viewer will play the game in the terminal for you watch"
        puts "There is an option to have the whole game play automatically, or to manually step through each move"
    end

    #clears screen with support windows
    def self.clear_screen
        OS.windows? ? system("cls") : system("clear")
    end
end

