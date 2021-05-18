require_relative "board"
require_relative "piece"
require_relative "square"
require_relative "file_reader"
require_relative "display"

require "egd"
require "json"

class Game
    attr_reader :player_white, :player_black
    attr_accessor :cur_board, :turn, :player_to_move
    def initialize(white, black)
        @cur_board = Board.new
        @turn = 1
        @player_to_move = "w"
        @player_white = white
        @player_black = black
    end

    def change_turn
        if @player_to_move == "w"
            @player_to_move = "b"
        else
            @player_to_move = "w"
        end
    end
end

