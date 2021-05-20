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
        valid_inputs = ["n", "b", "exit"]
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
end

