require_relative "Piece"

class Board

    attr_reader :board

    def initialize
        @board = Array.new(8) {Array.new(8) {Square.new}}
        setup_board
    end

    def clear_board
        @board = Array.new(8) {Array.new(8) {Square.new}}
    end

    def setup_board
        @board[0][0] = Piece.new(:Rook, :black)
        @board[0][1] = Piece.new(:Knight, :black)
        @board[0][2] = Piece.new(:Bishop, :black)
        @board[0][3] = Piece.new(:Queen, :black)
        @board[0][4] = Piece.new(:King, :black)
        @board[0][5] = Piece.new(:Bishop, :black)
        @board[0][6] = Piece.new(:Knight, :black)
        @board[0][7] = Piece.new(:Rook, :black)

        @board[7][0] = Piece.new(:Rook, :white)
        @board[7][1] = Piece.new(:Knight, :white)
        @board[7][2] = Piece.new(:Bishop, :white)
        @board[7][3] = Piece.new(:Queen, :white)
        @board[7][4] = Piece.new(:King, :white)
        @board[7][5] = Piece.new(:Bishop, :white)
        @board[7][6] = Piece.new(:Knight, :white)
        @board[7][7] = Piece.new(:Rook, :white)

        for i in 0...7 do
            @board[1][i] = Piece.new(:Pawn, :black)
            @board[6][i] = Piece.new(:Pawn, :white)
        end
    end

end