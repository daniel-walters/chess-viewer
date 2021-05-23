require "json"
require "egd"
require_relative "../game"

describe "Game" do
    before(:each) do
        @json_file = Egd::Builder.new(File.read("spec/test-input/FischerVsThomason.pgn")).to_json
        @data = JSON.parse(@json_file)
    end

    it "Should set time if given" do
        game = Game.new(@data, time=1)
        expect(game.time_between_turn).to be 1
    end

    it "Should set a valid default time if not specified" do
        game = Game.new(@data)
        expect(game.time_between_turn).to be > 0
    end

    it "Should initialize game on turn 1 white" do
        game = Game.new(@data)
        expect("#{game.turn}#{game.player_to_move}").to eq("1w")
    end

    describe ".increment_game" do
        before (:each) do
            @game = Game.new(@data)
        end

        it "Should change player from white to black if whites turn" do
            @game.increment_game
            expect("#{@game.turn}#{@game.player_to_move}").to eq("1b")
        end

        it "Should change player from black to white and increment turn if blacks turn" do
            @game.increment_game
            @game.increment_game
            expect("#{@game.turn}#{@game.player_to_move}").to eq("2w")
        end
    end

    describe ".fast_forward" do
        it "Should move the game forward to the specified move" do
            @game = Game.new(@data)
            @game.fast_forward("5b")
            expect("#{@game.turn}#{@game.player_to_move}").to eq("5b")
        end
    end
end

