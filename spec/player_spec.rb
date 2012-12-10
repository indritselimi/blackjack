require "spec_helper"

module Blackjack
  describe Player do
    include BlackjackHelpers

    let(:console) { double('console').as_null_object }
    let(:dealer) { double('dealer').as_null_object }
    let(:player) { Player.new(dealer, console) }

    def player_chooses(*choice)
      console.stub(:ask).and_return(*choice)
    end

    describe '.play' do
      it 'asks the dealer for the starting deal' do
        dealer.should_receive(:starting_deal)
        player.play
      end

      it 'asks the player' do
        player.should_receive(:ask)
        player.play
      end
    end


    describe '.ask' do
      it 'waits for player choice' do
        console.should_receive(:ask)
        player.ask
      end

      %w(hit stand).each do |choice|
        it "calls #{choice} if player chooses to #{choice}" do
          player_chooses(choice)

          player.should_receive(choice)
          player.ask
        end
      end

      it 're-asks if player choice not recognized ?'
    end

    describe '.hit' do
      before {
        dealer.stub(:deal).and_return(2)
      }

      it 'asks dealer for the next card' do
        dealer.should_receive(:deal)

        player.hit
      end

      it 'dealer wins if player looses' do
        dealer.stub(:deal).and_return(10, 10, 2)

        dealer.should_receive(:won)

        3.times.each { player.hit }
      end

      it 'ask the player' do
        player.should_receive(:ask)

        player.hit
      end
    end

    describe '.stand' do
      it 'stands' do
        dealer.should_receive(:hit)
        player.stand
      end
    end

    describe '.won' do
      it 'displays that the player won' do
        console.should_receive(:say).with("Player Wins!")
        console.should_receive(:say).with("\n")

        player.won
      end
    end

    context "when scores > 21" do
      it "looses" do
        dealer.stub(:deal).and_return(10, 10, 2)
        3.times.each { player.hit }

        player.loosed?.should be_true
      end
    end

    context 'player looses' do
      it 'chooses to hit and over scores' do
        player_chooses('hit')

        dealer = Dealer.new(deck(10, 6, 6), console)
        player = Player.new(dealer, console)

        dealer.should_receive(:won)
        player.play
      end

      it 'scores < dealer score' do
        player_chooses('stand')

        dealer = Dealer.new(deck(10, 6, 5), console)
        player = Player.new(dealer, console)

        dealer.should_receive(:won)
        player.play
      end

      it 'scores the same as dealer' do
        player_chooses('stand')

        dealer = Dealer.new(deck(10, 7), console)
        player = Player.new(dealer, console)

        dealer.should_receive(:won)
        player.play
      end
    end

    context 'player wins' do
      it 'chooses to stand and dealer over scores' do
        player_chooses('stand')

        dealer = Dealer.new(deck(10, 6, 6), console)
        player = Player.new(dealer, console)

        player.should_receive(:won)
        player.play
      end

      it 'chooses to hit and scores better than dealer' do
        player_chooses('hit', 'stand')

        dealer = Dealer.new(deck(10, 6, 4, 1), console)
        player = Player.new(dealer, console)

        player.should_receive(:won)
        player.play
      end
    end
  end
end