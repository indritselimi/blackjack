module Blackjack
  class Player
    attr_reader :score

    def initialize(dealer, console)
      @dealer = dealer
      @console = console
      @score = 0
    end

    def play
      @score = @dealer.starting_deal

      ask
    end

    def ask
      cmd = @console.ask 'Player: '

      case cmd.to_sym
        when :hit then
          hit
        when :stand then
          stand
        else
          @console.say "I can only understand: 'hit' or 'stand'.\n"
      end
    end

    def hit
      @score += @dealer.deal

      if loosed?
        @dealer.won
      else
        ask
      end
    end

    def stand
      @dealer.hit

      if @dealer.loosed?
        won
      else
        [@dealer, self].max { |p, d| p.score <=> d.score }.won
      end
    end

    def loosed?
      @score > 21
    end

    def won
      @console.say 'Player Wins!'
      @console.say "\n"
    end
  end
end