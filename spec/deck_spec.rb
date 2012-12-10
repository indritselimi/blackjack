require "spec_helper"

module Blackjack
  describe Deck do
    let(:deck) { Deck.new(1, 2, 3) }
    let(:original_deck) { Deck.new(1, 2, 3) }

    context '.card ' do
      it "returns the next card" do
        deck.card.should == 3
        deck.card.should == 2
        deck.card.should == 1
      end

      it "raises an error if no more cards are left" do
        deck = Deck.new()
        expect { deck.card }.to raise_error(Deck::Empty)
      end
    end

    context '.shuffle!' do
      it "shuffles the initial card set" do
        2.times { deck.card }
        deck.should_not == original_deck
        deck.shuffle!
        deck.should == original_deck
      end
    end
  end
end