class PlayLogic
  def start
    @dialer = Dialer.new("dialer")
    puts "Please, put your name"
    name = gets.chomp
    @player = Player.new(name)
    @player.get_first_cards
    @dialer.get_first_cards
    @bank = 20
    @player.money -= 10
    @dialer.money -= 10
  end

  def start_from_play
    @bank = 20
    @player.money -= 10
    @dialer.money -= 10
    @player.cards = []
    @dialer.cards = []
    puts @player.cards
    puts @dialer.cards
    Person.update_cards
    @dialer.get_first_cards
    @player.get_first_cards
    view { print "*" }
  end

  def play
    flg = true
    start
    view { print "*" }
    while !@dialer.money.zero? && !@player.money.zero? && flg
      puts "1.Take card, 2.Pass 3.Open cards"
      num = gets.chomp.to_i
      if @dialer.cards.length == 3 && @player.cards.length == 3
        num = 3
        puts "Both have 3 cards"
      end
      case num
      when 1
        @player.get_card
        view { print "*" }
      when 2
        @dialer.points < 17 ? @dialer.get_card : puts("Dialer pass")
        view { print "*" }
      when 3
        view { |x| print "#{x[0]} #{x[1]} " }
        puts "Dialer's points  #{@dialer.points}"
        if @dialer.points > @player.points || (@dialer.points < 22 && @player.points > 21)
          @dialer.money += @bank
          puts "Dialer is winner"
        else
          if @dialer.points < @player.points || (@player.points < 22 && @dialer.points > 21)
            @player.money += @bank
            puts "You are winner"
          else
            @player.money += @bank / 2
            @dialer.money += @bank / 2
            (@dialer.points < 22 && @player.points < 22) ? puts("Both won") : puts("Both lose")
          end
        end
        puts "Money: #{@player.money}"
        @bank = 0
        puts "1.Play one more time  2.Exit"
        i = gets.chomp.to_i
        flg = false
        if i == 1 && @player.money >= 10 && @dialer.money >= 10
          flg = true
          start_from_play
        end
      end
    end
    puts "Someone has no money" if flg

  end

  def view(&block)
    puts "Your cards                Dealer's cards"
    @player.show_cards
    print "                "
    @dialer.cards.each { |card| block.call(card) }
    puts
    puts "Your points #{@player.points} "

  end

end
