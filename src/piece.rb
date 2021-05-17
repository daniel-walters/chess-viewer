class Piece

    attr_reader :type

    @@unicodes = {:Pawn => "\u2659", :Knight => "\u2658", :Bishop => "\u2657", :Rook => "\u2656", :Queen => "\u2655", :King => "\u2654"}

    def initialize(type)
        @type  = type
    end

    def to_s
        @@unicodes[type]
    end
end
