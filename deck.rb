class Deck

  CARDS_NAME = ["К", "Д", "Т", "В", "10", "9", "8","7", "6", "5", "4", "3", "2"]
  CARDS_SUIT = ["+", "<3", "^", "<>"]
  CARD_W = /[А-Я]/

  def initialize
  end

  def self.generate_cards
    @@all_cards = []
    CARDS_SUIT.each do |suit|
      CARDS_NAME.each do |name|
        if name =~ CARD_W
          @@all_cards.push(Card.new(name + suit, 10))
        else
          @@all_cards.push(Card.new(name + suit, name.to_i))
        end
      end
    end
  end

  def give_card
    i = rand(@@all_cards.length - 1)
    card = @@all_cards[i]
    @@all_cards.delete_at(i)
    card
  end

end
