require_relative "board"
require_relative "piece"
require_relative "square"
require_relative "file_reader"
require_relative "display"

require "egd"
require "json"

class Game
    attr_accessor :cur_board, :turn, :player_to_move
    def initialize
        @cur_board = Board.new
        @turn = 1
        @player_to_move = "w"
    end

    def change_turn
        if @player_to_move == "w"
            @player_to_move = "b"
        else
            @player_to_move = "w"
        end
    end
end

