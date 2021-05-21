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

    def initialize(data, time = 3)
        @data = data
        @cur_board = Board.new
        @turn = 1
        @player_to_move = "w"
        @player_white = data["game_tags"]["White"]
        @player_black = data["game_tags"]["Black"]    
        @time_between_turn = time
    end

    def reset_game
        @cur_board.clear_board
        @cur_board.setup_board
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

    def increment_game
        change_turn
        @turn += 1 if @player_to_move == "w"
    end

    def view_turn
        Display.draw_board(@cur_board, @player_white, @player_black)
        Display.move_info(@turn, @player_to_move, FileReader.get_move("#{@turn}#{@player_to_move}", @data))
    end

    def play_full_game
        system "clear"
        Display.draw_board(@cur_board, @player_white, @player_black)
        Display.game_start_ui
        fast_forward(@data["moves"].keys[-1], true)
        Display.draw_board(@cur_board, @player_white, @player_black)
        Display.game_end_ui(determine_winner)
    end

    def fast_forward(to, display = false)
        reset_game
        first_move = true

        if (to == "1w")
            play_turn
        else
            until "#{@turn}#{@player_to_move}" == to do
                !first_move ? increment_game : first_move = false
                play_turn
                if display
                    view_turn
                    sleep(@time_between_turn)
                    system "clear"
                end
            end
        end
    end

    def play_turn
        move_info = FileReader.get_move("#{@turn}#{@player_to_move}", @data)    
        @cur_board.move_piece(move_info)
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

    def play_manual
        first_move = true
        system "clear"
        Display.draw_board(@cur_board, @player_white, @player_black)
        puts "Starting Position"

        while (true)
            case Display.man_menu
            when "n"
                if "#{@turn}#{@player_to_move}" != @data["moves"].keys[-1]
                    !first_move ? increment_game : first_move = false
                    play_turn
                else
                    puts "End of Game, Can't go forward"
                    sleep(1)
                end
            when "b"
                if "#{@turn}#{@player_to_move}" == "1w"
                    if (first_move)
                        puts "Start of Game, Can't go back"
                        sleep(1)
                    else
                        first_move = true
                        reset_game
                    end
                else
                    change_turn
                    @turn -=1 if player_to_move == "b"
                    fast_forward("#{@turn}#{@player_to_move}")
                end
            when "goto"
                move = Display.get_move
                valid  = validate_move(move)
                if valid
                    first_move = false
                    fast_forward(move)
                else
                    puts "Error not a valid move"
                    sleep(1)
                end
            when "exit"
                exit
            end
            system "clear"
            if first_move
                Display.draw_board(@cur_board, @player_white, @player_black)
                puts "Starting Position"
            else
                view_turn
            end

            if "#{@turn}#{@player_to_move}" == @data["moves"].keys[-1] then Display.game_end_ui(determine_winner) end
        end
    end

    private

    def validate_move(move)       
            move_from_file = @data["moves"][move]
            move_from_file ? valid = true : valid = false
    end
end

