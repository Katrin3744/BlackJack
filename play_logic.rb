class PlayLogic
  def start
    Person.gen_cards
    @view = View.new
    @dialer = Dialer.new
    attempt = 0
    begin
      @view.view_for_string("Please, put your name")
      attempt += 1
      name = @view.get_str
      @player = Player.new(name)
    rescue RuntimeError => e
      puts e.inspect
      if attempt >= 3
        puts "#{attempt} attempt, your name will be 'name' "
        @player = Player.new("name")
      end
      retry if attempt < 3
    end
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
    Person.gen_cards
    @dialer.get_first_cards
    @player.get_first_cards
    @view.view_with_block(@player, @dialer) { print "*" }
  end

  def play
    @flg = true
    start
    @num_move = 0
    @view.view_with_block(@player, @dialer) { print "*" }
    while !@dialer.money.zero? && !@player.money.zero? && @flg
      if @num_move % 2 == 0
        @view.view_for_string("1.Take card, 2.Pass 3.Open cards")
        num = @view.get_num
      else
        num = 2
        @view.view_for_string("Dialer's move")
      end
      if @dialer.cards.length == 3 && @player.cards.length == 3
        num = 3
        @view.view_for_string("Both have 3 cards")
      end

      case num
      when 1
        player_move
      when 2
        dialer_move
      when 3
        new_play_exit
      end
    end
    @view.view_for_string("Someone has no money") if @flg

  end

  def player_move
    @player.get_card
    @view.view_with_block(@player, @dialer) { print "*" }
    @num_move += 1
  end

  def dialer_move
    @num_move % 2 == 0 ? @num_move += 2 : @num_move += 1
    @dialer.get_points < 17 ? @dialer.get_card : @view.view_for_string("Dialer pass")
    @view.view_with_block(@player, @dialer) { print "*" }
  end

  def new_play_exit
    @num_move = 0
    @view.view_with_block(@player, @dialer) { |x| print "#{x.suit} #{x.value} " }
    @view.view_for_string("Dialer's points  #{@dialer.get_points}")
    if (@dialer.get_points > @player.get_points || @player.get_points > 21) && @dialer.get_points < 22
      @dialer.money += @bank
      @view.view_for_string("Dialer is winner")
    else
      if (@player.get_points > @dialer.get_points || @dialer.get_points > 21) && @player.get_points < 22
        @player.money += @bank
        @view.view_for_string("You are winner")
      else
        @player.money += @bank / 2
        @dialer.money += @bank / 2
        (@dialer.get_points < 22 && @player.get_points < 22) ? @view.view_for_string("Both won") : @view.view_for_string("Both lose")
      end
    end
    @view.view_for_string("Money: #{@player.money}")
    @bank = 0
    @view.view_for_string("1.Play one more time  2.Exit")
    i = @view.get_num
    @flg = false
    if i == 1 && @player.money >= 10 && @dialer.money >= 10
      @flg = true
      start_from_play
    end
  end

end
