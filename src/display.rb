require "colorize"
class Display

    def self.draw_board(board_obj, white, black)
        board = board_obj.board

        puts "#{white} (Black) Vs. #{black} (Black)"
        board.each_with_index do |row, row_i|
            row.each_with_index do |square, square_i|
                if (row_i + square_i).odd?
                    print square.to_s.colorize(:background => :blue)
                else
                    print square.to_s.colorize(:background => :yellow)
                end
            end
            print "\n"
        end
    end

    def self.move_info(cur_turn, cur_to_move, data)
        puts "Turn #{cur_turn}, #{cur_to_move == "w" ? "Whites" : "Blacks"} move"
        puts get_commentary(data, cur_to_move)
    end

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
        system "clear"
    end

    def self.game_end_ui(winner)
        puts "Final Position"
        puts "#{winner}"
    end
    
    def self.menu
        system "clear"
        prompt = "Choose an option\n1) Automatic\n2) Manual\n3) Exit\n"
        print prompt
        input = gets.chomp.to_i
        while input > 3 || input < 1 do
            system "clear"
            puts "Invalid input"
            print prompt
            input = gets.chomp.to_i
        end
        case input
        when 1
            return 1
        when 2
            return 2
        when 3
            return 3
        else
            return 3
        end
    end

    def self.man_menu
        valid_inputs = ["n", "b", "exit", "goto"]
        prompt = "Type 'n' to go next, 'b' to go back, or 'exit' to exit\n"
        print prompt
        input = gets.chomp.downcase

        while !valid_inputs.include?(input)
            puts "error"
            print prompt
            input = gets.chomp.downcase
        end

        return input
    end

    def self.get_move
        puts "Enter a move to go to"
        input = gets.chomp.downcase
    end

    def self.get_commentary(move_info, player)
        com = ""
        player == "w" ? com += "White plays " : com += "Black plays "
        com += "#{piece_short_to_long(move_info[:piece])} from "
        com += "#{move_info[:to]} to #{move_info[:from]}."
        if move_info[:captured_piece] then com += " Capturing a #{piece_short_to_long(move_info[:captured_piece])}." end
        if move_info[:promote_to] then com += " Promoting to a #{piece_short_to_long(move_info[:promote_to])}." end
        if move_info[:check] then com += " Check!" end
        if move_info[:checkmate] then com += " Checkmate!" end

        return com
    end

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
end

