require "json"
require "egd"

class FileReader
    attr_reader :file, :data

    def initialize(file)
        @file = file
        @data = get_data
    end

    def self.get_move(move, data)
        piece_moved = data["moves"][move]["move"]["piece"]
        from = data["moves"][move]["move"]["from_square"]
        to = data["moves"][move]["move"]["to_square"]

        {:piece_moved => piece_moved, :from => from, :to => to}
    end
        

    private

    def get_data
        json_file = Egd::Builder.new(File.read(@file)).to_json
        data = JSON.parse(json_file)
    end

end