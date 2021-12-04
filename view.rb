class View
  def get_num
    gets.chomp.to_i
  end

  def get_str
    gets.chomp
  end

  def view_for_string(str)
    puts str
  end

  def view_with_block(player,dialer,&block)
    puts "Your cards                Dealer's cards"
    player.person_hand.cards.each{|card| print "#{card.suit} #{card.value} "}
    print "              "
    dialer.person_hand.cards.each { |card| block.call(card) }
    puts
    puts "Your points #{player.get_points} "
  end

end
