require "os"
class Piece

    attr_reader :type, :color

    @@unicodes = {  :Pawn => "\u265F", 
                    :Knight => "\u265E", 
                    :Bishop => "\u265D", 
                    :Rook => "\u265C", 
                    :Queen => "\u265B", 
                    :King => "\u265A"}

    #unicodes not supported on windows by default
    @@windows_pieces = {:Pawn => "P",
                        :Knight => "N",
                        :Bishop => "B",
                        :Rook => "R",
                        :Queen => "Q",
                        :King => "K"}

    def initialize(type, color)
        @type  = type
        @color = color
    end

    def to_s
        if OS.windows? then @@windows_pieces[type].colorize(color)
        else @@unicodes[type].colorize(color) end
    end
end
