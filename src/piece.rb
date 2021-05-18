class Piece

    attr_reader :type, :color

    @@unicodes = {  :Pawn => "\u2659", 
                    :Knight => "\u2658", 
                    :Bishop => "\u2657", 
                    :Rook => "\u2656", 
                    :Queen => "\u2655", 
                    :King => "\u2654"}

    def initialize(type, color)
        @type  = type
        @color = color
    end

    def to_s
        @@unicodes[type]
    end
end
