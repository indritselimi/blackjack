module Blackjack
  class Console
    def initialize(input, output=input)
      @in = input
      @out =output
    end

    def say(something)
      @out << something
    end

    def ask(question='')
      say(question)

      @in.gets.chomp
    end
  end
end
