class Person
  attr_reader :name,  :play_cards
  attr_accessor :money, :person_hand

  def initialize
    @play_cards=Deck.new
    @money = 100
    @person_hand=Hand.new
  end

  def get_first_cards
    get_card
    get_card
  end

  def get_card
    if  @person_hand.cards.length < 3
      @person_hand.cards.push(@play_cards.give_card)
    end
  end

  def get_points
    @person_hand.num_points
  end

end
