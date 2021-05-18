require "json"
require "egd"

class FileReader
    attr_reader :file, :data

    def initialize(file)
        @file = file
        @data = get_data
    end

    def get_FEN(move)
        full_fen = @data["moves"][move]["start_position"]["fen"]
        board_order = full_fen.split()[0]
    end

    def get_board_array(fen)
        fen.split("/")
    end
        

    private

    def get_data
        json_file = Egd::Builder.new(File.read(@file)).to_json
        data = JSON.parse(json_file)
    end

end