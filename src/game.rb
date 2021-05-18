require_relative "board"
require_relative "piece"
require_relative "square"
require_relative "file_reader"
require_relative "display"

require "egd"
require "json"

class Game
    attr_reader :player_white, :player_black, :data
    attr_accessor :cur_board, :turn, :player_to_move
    def initialize(data)
        @data = data
        @cur_board = Board.new
        @turn = 1
        @player_to_move = "w"
        @player_white = data["game_tags"]["White"]
        @player_black = data["game_tags"]["Black"]    
    end

    def change_turn
        if @player_to_move == "w"
            @player_to_move = "b"
        else
            @player_to_move = "w"
        end
    end

    def play_turn
        move_info = FileReader.get_move("#{@turn}#{@player_to_move}", @data)
        cur_board.move_piece(move_info)
        change_turn
        turn += 1 if @player_to_move == "w"
    end
end

