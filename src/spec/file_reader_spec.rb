require_relative "../file_reader"




describe "File_Reader" do
    before(:each) do
        @reader = FileReader.new("spec/test-input/FischerVsThomason.pgn")
    end

    it "should grab data from the file and turn into a Hash on initialization" do
        expect(@reader.data).to be_a Hash
    end

    describe ".get_move" do
        it "should return a Hash if valid input" do
            expect(FileReader.get_move("1w", @reader.data)).to be_a Hash
        end

        it "shold return nil if invalid input" do
            expect(FileReader.get_move("100w", @reader.data)).to be nil
        end
    end
end