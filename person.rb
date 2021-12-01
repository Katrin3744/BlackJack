class Person
  attr_reader :name, :points
  attr_accessor :money, :cards

  def self.update_cards
  @@all_cards_first = { "K+" => 10, "K^" => 10, "K<>" => 10, "K<3" => 10,
                       "Д+" => 10, "Д^" => 10, "Д<>" => 10, "Д<3" => 10,
                       "Т+" => 11, "Т^" => 11, "Т<>" => 11, "Т<3" => 11,
                       "В+" => 10, "в^" => 10, "в<>" => 10, "В<3" => 10,
                       "10+" => 10, "10^" => 10, "10<>" => 10, "10<3" => 10,
                       "9+" => 9, "9^" => 9, "9<>" => 9, "9<3" => 9,
                       "8+" => 8, "8^" => 8, "8<>" => 8, "8<3" => 8,
                       "7+" => 7, "7^" => 7, "7<>" => 7, "7<3" => 7,
                       "6+" => 6, "6^" => 6, "6<>" => 6, "6<3" => 6,
                       "5+" => 5, "5^" => 5, "5<>" => 5, "5<3" => 5,
                       "4+" => 4, "4^" => 4, "4<>" => 4, "4<3" => 4,
                       "3+" => 3, "3^" => 3, "3<>" => 3, "3<3" => 3,
                       "2+" => 2, "2^" => 2, "2<>" => 2, "2<3" => 2 }; # change on def create_card define_method with array of name and type
  @@all_cards = @@all_cards_first.to_a
  end

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
    self.class.update_cards
  end

  def get_first_cards
    get_card
    get_card
  end

  def get_card
    if @cards.length < 3
      i = rand(@@all_cards.length)
      @cards.push(@@all_cards[i])
      @@all_cards.delete_at(i)
      num_points
    end
  end

  def show_cards
    @cards.each { |card| print "#{card[0]} #{card[1]} " }
  end

  def num_points
    @points = 0
    @cards.each do |card|
      if card[0].start_with?("Т")
        @points + 11 <= 21 ? @points += card[1] : @points += 1
      else
        @points += card[1]
      end
    end
  end

end
