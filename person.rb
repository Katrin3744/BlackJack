class Person
  attr_reader :name, :person_points, :play_cards
  attr_accessor :money, :cards

  def initialize
    @play_cards=Deck.new
    @money = 100
    @cards = []
    @person_points=Hand.new
  end

  def self.gen_cards
    Deck.generate_cards
  end

  def get_first_cards
    get_card
    get_card
  end

  def get_card
    if @cards.length < 3
      @cards.push(@play_cards.give_card)
      @person_points.num_points(@cards)
    end
  end

  def get_points
    @person_points.points
  end

end
