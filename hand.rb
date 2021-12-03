class Hand
  attr_reader :points

  def initialize
    @points = 0
  end

  def num_points(cards)
    @points = 0
    cards.each do |card|
      if card.suit.start_with?("Т")
        if @points + 11 <= 21
          @points += 11
          card.value = 11
        else
          @points += 1
          card.value == 1
        end
      else
        @points += card.value
      end
    end
  end

end
