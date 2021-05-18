require_relative "board"
require_relative "piece"
require_relative "square"
require_relative "file_reader"
require_relative "display"

require "egd"
require "json"

class Game
    attr_reader :player_white, :player_black, :data
    attr_accessor :cur_board, :turn, :player_to_move, :game_over
    def initialize(data)
        @data = data
        @cur_board = Board.new
        @turn = 1
        @player_to_move = "w"
        @player_white = data["game_tags"]["White"]
        @player_black = data["game_tags"]["Black"]    
        @game_over = false
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
        if move_info == nil
            @game_over = true
        else
            @cur_board.move_piece(move_info)
            change_turn
            @turn += 1 if @player_to_move == "w"
        end
    end

    def play_full_game
        puts "Game Starting!"
        sleep(1)
        system "clear"
        draw_board(@cur_board)
        while !@game_over do
            play_turn
            sleep(1)
            system "clear"
            draw_board(@cur_board)
        end
        puts "Game Over!"
    end
end

