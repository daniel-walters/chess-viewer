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
    def initialize(data, time = 3)
        @data = data
        @cur_board = Board.new
        @turn = 1
        @player_to_move = "w"
        @player_white = data["game_tags"]["White"]
        @player_black = data["game_tags"]["Black"]    
        @game_over = false
        @time_between_turn = time
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

    def determine_winner
        result = @data["game_tags"]["Result"]
        whites_result = result.split("-")
        if whites_result == "1"
            "White Wins!"
        elsif whites_result == "1/2"
            "It's a draw!"
        else
            "Black Wins!"
        end
    end

    def play_full_game
        puts "Game Starting!"
        sleep(1)
        system "clear"
        Display.draw_board(@cur_board)
        puts "Starting Position"
        while !@game_over do
            cur_turn = @turn
            cur_to_move = @player_to_move
            play_turn
            sleep(@time_between_turn)
            system "clear"
            puts "#{player_white} (White) Vs. #{player_black} (Black)"
            Display.draw_board(@cur_board)
            Display.move_info(cur_turn, cur_to_move, @data)
        end
        puts "Game Over!"
        puts determine_winner
    end
end

