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
end

