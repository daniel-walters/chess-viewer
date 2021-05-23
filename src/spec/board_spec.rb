require_relative "../board"

describe "Board" do
    before(:each) do
        @board = Board.new
    end
    
    it "should create a 2d array of squares" do
        expect(@board.board).to be_a Array
        expect(@board.board[0]).to be_a Array
        expect(@board.board[0][0]).to be_a Square
    end

    describe ".convert_coord_to_index" do
        it "should return a Hash" do
            expect(@board.convert_coord_to_index("a1")).to be_a Hash
        end
        it "should convert board coordinates to its relative index position in the 2d array" do
            expect(@board.convert_coord_to_index("a1")[:row]).to eq 7
            expect(@board.convert_coord_to_index("a1")[:col]).to eq 0
        end
    end

    describe ".move_piece" do
        it "should move a piece from one square to another" do
            @board.move_piece({:from => "e2", :to => "e4", :type => "move"})
            expect(@board.board[4][4].piece).to be_truthy
            expect(@board.board[6][4].piece).to be_falsy
        end
        it "should promote a pawn to a different piece" do
            @board.board[7][0].piece = nil
            @board.move_piece({:from => "a2", :to => "a1", :type => "promotion", :promote_to => "Q"})
            expect(@board.board[6][0].piece).to be_falsy
            expect(@board.board[7][0].piece).to be_truthy
            expect(@board.board[7][0].piece.type).to eq :Queen
        end
        it "should complete a valid en passant" do
            @board.board[4][3].piece = Piece.new(:Pawn, :white)
            @board.board[4][4].piece = Piece.new(:Pawn, :black)
            @board.move_piece({:from => "d4", :to => "e5", :type => "ep_capture"})
            expect(@board.board[4][3].piece).to be_falsy
            expect(@board.board[4][4].piece).to be_falsy
            expect(@board.board[3][4].piece).to be_truthy
        end
        it "should castle long" do
            @board.move_piece({:from => "e1", :to => "c1", :type => "long_castle"})
            expect(@board.board[7][2].piece.type).to eq :King
            expect(@board.board[7][3].piece.type).to eq :Rook
        end
        it "should castle short" do
            @board.move_piece({:from => "e1", :to => "g1", :type => "short_castle"})
            expect(@board.board[7][6].piece.type).to eq :King
            expect(@board.board[7][5].piece.type).to eq :Rook
        end
    end
end