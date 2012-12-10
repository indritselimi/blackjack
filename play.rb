#!/usr/bin/env ruby

$LOAD_PATH << 'lib'

require 'blackjack'


module Blackjack
  def self.play
    deck = Deck.new(*((1..14).to_a * 4))

    console = Console.new(STDIN, STDOUT)

    Player.new(Dealer.new(deck, console), console).play
  end
end

Blackjack.play