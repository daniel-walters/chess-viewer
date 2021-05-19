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

    def convert_coord_to_index(coord)
        col = ((coord[0].ord - 49).chr).to_i
        row = 7 - (coord[1].to_i - 1)

        {:row => row, :col => col}
    end

    def move_piece(move_info)
        from_ind = convert_coord_to_index(move_info[:from])
        to_ind = convert_coord_to_index(move_info[:to])
        type = move_info[:type]

        case type
        when "short_castle"
            short_castle(from_ind[:row])
        when "long_castle"
            long_castle(from_ind[:row])
        when "promotion_capture", "promotion"
            promote(from_ind, to_ind, move_info[:promote_to])
        when "ep_capture"
            en_passant(from_ind, to_ind)
        else
           move_or_capture(from_ind, to_ind) 
        end 
    end

    def move_or_capture(from_ind, to_ind)
        #grab piece to be moved
        piece_to_be_moved = @board[from_ind[:row]][from_ind[:col]].piece
        #place it where it is moving to
        @board[to_ind[:row]][to_ind[:col]].piece = piece_to_be_moved
        #empty the original square
        @board[from_ind[:row]][from_ind[:col]].piece = nil
    end

    def en_passant(from_ind, to_ind)
        move_or_capture(from_ind, to_ind)
        #remove captured piece
        if from_ind[:row] > to_ind[:row]
            @board[to_ind[:row] + 1][to_ind[:col]].piece = nil
        else
            @board[to_ind[:row] - 1][to_ind[:col]].piece = nil
        end
    end

    def short_castle(row)
        #get king
        piece_to_be_moved = @board[row][4].piece
        #move king to specific square
        @board[row][6].piece = piece_to_be_moved
        #get rook
        piece_to_be_moved = @board[row][7].piece
        #move rook to specific square
        @board[row][5].piece = piece_to_be_moved
        #clear original squares       
        @board[row][4].piece = nil
        @board[row][7].piece = nil
    end

    def long_castle(row)
        #get king
        piece_to_be_moved = @board[row][4].piece
        #move king to specific square   
        @board[row][2].piece = piece_to_be_moved
        #get rook
        piece_to_be_moved = @board[row][0].piece
        #move rook to specific square
        @board[row][3].piece = piece_to_be_moved
        #clear original squares       
        @board[row][4].piece = nil
        @board[row][0].piece = nil
    end

    def promote(from_ind, to_ind, promote_to)
        move_or_capture(from_ind, to_ind)
        target_square = @board[to_ind[:row]][to_ind[:col]]
        piece_color = target_square.piece.color

        case promote_to
        when "N"
            target_square.piece = Piece.new(:Knight, piece_color)
        when "B"
            target_square.piece = Piece.new(:Bishop, piece_color)
        when "R"
            target_square.piece = Piece.new(:Rook, piece_color)
        when "Q"
            target_square.piece = Piece.new(:Queen, piece_color)
        end
    end
end