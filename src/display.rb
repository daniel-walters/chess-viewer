require "colorize"


def draw_board(board)
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
