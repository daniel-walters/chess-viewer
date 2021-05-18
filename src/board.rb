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
        @board[0][0].piece = Piece.new(:Rook, :black)
        @board[0][1].piece = Piece.new(:Knight, :black)
        @board[0][2].piece = Piece.new(:Bishop, :black)
        @board[0][3].piece = Piece.new(:Queen, :black)
        @board[0][4].piece = Piece.new(:King, :black)
        @board[0][5].piece = Piece.new(:Bishop, :black)
        @board[0][6].piece = Piece.new(:Knight, :black)
        @board[0][7].piece = Piece.new(:Rook, :black)

        @board[7][0].piece = Piece.new(:Rook, :white)
        @board[7][1].piece = Piece.new(:Knight, :white)
        @board[7][2].piece = Piece.new(:Bishop, :white)
        @board[7][3].piece = Piece.new(:Queen, :white)
        @board[7][4].piece = Piece.new(:King, :white)
        @board[7][5].piece = Piece.new(:Bishop, :white)
        @board[7][6].piece = Piece.new(:Knight, :white)
        @board[7][7].piece = Piece.new(:Rook, :white)

        for i in 0..7 do
            @board[1][i].piece = Piece.new(:Pawn, :black)
            @board[6][i].piece = Piece.new(:Pawn, :white)
        end
    end

end