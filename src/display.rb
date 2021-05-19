require "colorize"
class Display

    def self.draw_board(board_obj)
        board = board_obj.board
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
            1
        when 2
            2
        when 3
            3
        else
            3
        end
    end
end

