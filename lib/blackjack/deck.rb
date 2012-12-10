module Blackjack
  class Deck
    def initialize(*card_set)
      @card_set = card_set.to_a

      @original_card_set = @card_set.clone.freeze
    end

    def card
      @card_set.pop || fail(Empty)
    end

    def shuffle!
      @card_set = @original_card_set.shuffle
    end


    def ==(other)
      @original_card_set.sort == other.instance_eval("@original_card_set").sort &&
      @card_set.sort == other.instance_eval("@card_set").sort
    end

    def hash
      @original_card_set.hash
    end

    Empty = Class.new RuntimeError
  end
end