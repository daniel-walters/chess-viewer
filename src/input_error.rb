class InputError < StandardError
    def initialize(msg="Error: Not a Valid Input, try again")
        super(msg)
    end
end