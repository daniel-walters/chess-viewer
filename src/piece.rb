class Piece

    attr_reader :type, :color

    @@unicodes = {  :Pawn => "\u265F", 
                    :Knight => "\u265E", 
                    :Bishop => "\u265D", 
                    :Rook => "\u265C", 
                    :Queen => "\u265B", 
                    :King => "\u265A"}

    def initialize(type, color)
        @type  = type
        @color = color
    end

    def to_s
        @@unicodes[type].colorize(color)
    end
end
