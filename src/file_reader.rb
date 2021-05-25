require "json"
require "egd"

class FileReader
    attr_reader :file, :data

    def initialize(file)
        @file = file
        @data = get_data
    end

    def self.get_move(move, data)
        begin
        from = data["moves"][move]["move"]["from_square"]
        to = data["moves"][move]["move"]["to_square"]
        type = data["moves"][move]["move"]["move_type"]
        piece = data["moves"][move]["move"]["piece"]
        data["moves"][move]["move"]["promotion"] ? promote_to = data["moves"][move]["move"]["promotion"] : promote_to = nil
        data["moves"][move]["move"]["captured_piece"] ? captured_piece = data["moves"][move]["move"]["captured_piece"] : captured_piece = nil
        data["moves"][move]["end_position"]["features"]["check"] ? check = data["moves"][move]["end_position"]["features"]["check"] : check = nil
        data["moves"][move]["end_position"]["features"]["checkmate"] ? checkmate = data["moves"][move]["end_position"]["features"]["checkmate"] : checkmate = nil
        rescue
            return nil
        end
        {:type => type, :from => from, :to => to, :piece => piece, :promote_to => promote_to,
         :captured_piece => captured_piece, :check => check, :checkmate => checkmate}
    end
        
    private

    def get_data
        json_file = Egd::Builder.new(File.read(@file)).to_json
        data = JSON.parse(json_file)
    end

end