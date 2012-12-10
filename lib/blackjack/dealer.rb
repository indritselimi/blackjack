class Dealer
  attr_reader :score

  def initialize(deck, console)
    @deck = deck
    @console = console
    @score = 0
  end

  def starting_deal
    begin
      hand = first_deal
    end until hand < 20
    hand
  end

  def first_deal
    @deck.shuffle!
    notify(@console) do
      @score = double_hand.value
    end
  end

  def deal
    notify(@console) do
      single_hand.value
    end
  end

  def hit
    return if stand?

    notify(@console) do
      until (stand? || loosed?) do
        @score += single_hand.value
      end
    end
  end

  def stand?
    @score >= 17
  end

  def loosed?
    @score > 21
  end

  def won
    @console.say "Dealer Wins!\n"
  end


  Hand = Struct.new(:card) do
    def value
      card
    end

    def +(other)
      value + other
    end

    def coerce(other)
      [other, value]
    end

    def to_s
      "#{card}"
    end
  end

  DoubleHand = Struct.new(:first_hand, :second_hand) do
    def value
      first_hand + second_hand
    end

    def to_s
      "#{first_hand} #{second_hand}"
    end
  end

  private

  def double_hand
    hand = DoubleHand.new(@deck.card, @deck.card)
    @console.say "#{hand}"
    hand
  end

  def single_hand
    hand = Hand.new(@deck.card)
    @console.say "#{hand}"
    @console.say " "
    hand
  end

  def notify(console)
    console.say "Dealer: "
    res = yield console
    console.say "\n"
    res
  end
end
