class Card
  attr_reader :suit
  attr_accessor :value

  def initialize(suit,value)
    @suit=suit
    @value=value
  end
end
