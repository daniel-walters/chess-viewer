require "colorize"
class Square
    attr_accessor :piece

    def initialize(piece = nil)
        @piece = piece
    end

    def to_s
        if @piece
            " #{piece.to_s} "
        else
            "   "
        end
    end
end