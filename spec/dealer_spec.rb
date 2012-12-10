require "spec_helper"

module Blackjack
  describe Dealer do
    include BlackjackHelpers

    let(:console) { double().as_null_object }
    let(:deck_mock) { deck() }

    context '.starting_deal' do
      it 'shuffles the deck' do
        deck_mock.should_receive(:shuffle!)
        Dealer.new(deck_mock, console).starting_deal
      end

      it 'returns the first hand composed by 2 cards' do
        deck_mock.should_receive(:card).twice
        Dealer.new(deck_mock, console).starting_deal
      end

      it 'displays the current hand (2 cards)' do
        ['Dealer: ', '2 2'].map { |m| console.should_receive(:say).with(m).ordered }
        Dealer.new(deck(2, 2), console).starting_deal
      end

      it 're-deals if cards values >= 20' do
        given_a_dealer_with(deck(10, 10, 10, 10, 2, 2)) { |d| d.starting_deal.should == 4 }
      end
    end

    context '.deal' do
      it 'deals the next card' do
        given_a_dealer_with(deck(2)) { |d| d.deal.should == 2 }
      end

      it 'displays the current deal' do
        ["Dealer: ", "2", "\n"].map { |m| console.should_receive(:say).with(m).ordered }
        Dealer.new(deck(2), console).deal
      end
    end

    context '.hit' do
      it 'requests another card until it stands' do
        given_a_dealer_with(deck(10, 7, 2)) do |d|
          d.hit
          d.stand?.should be_true
          d.score.should == 17
        end
      end

      it 'or until it looses' do
        given_a_dealer_with(deck(10, 6, 6, 2)) do |d|
          d.hit
          d.loosed?.should be_true
          d.score.should == 22
        end
      end

      it 'displays requested cards' do
        ["Dealer: ", "2", "3", "4", "10", "\n"].map { |m| console.should_receive(:say).with(m).ordered }
        dealer = Dealer.new(deck(2, 3, 4, 10), console)
        dealer.hit
      end
    end

    context "when scores > 21" do
      it "looses" do
        given_a_dealer_with(deck(10, 6, 6)) do |d|
          d.starting_deal
          d.loosed?.should be_false
          d.hit
          d.loosed?.should be_true
        end
      end
    end

    context "when scores >= 17" do
      it "stand" do
        given_a_dealer_with(deck(10, 7)) do |d|
          d.starting_deal
          d.stand?.should be_true
        end
      end
    end
  end
end