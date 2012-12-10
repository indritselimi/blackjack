require "rspec"
require 'blackjack'

module BlackjackHelpers
  def deck(*cards)
    deck = double('deck').as_null_object
    deck.stub(:card).and_return(*cards) unless cards.empty?
    deck
  end

  def given_a_dealer_with(deck)
    yield Dealer.new(deck, console)
  end
end
