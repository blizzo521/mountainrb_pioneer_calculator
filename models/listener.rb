class Listener


  def initialize(player)
    @player = player
    greet
    get_pioneer_type
    get_cards
    summarize_cards(player)
    display_score(player)
    spin_yarn(player)
  end

  private

  def greet
    print "Howdy pard'ner, whats yer name?"
    print prompt
    @player.name = gets.chomp
  end

  def get_pioneer_type
    print "Nice to meet'cha, #{@player.name}.  What sort of pioneer are ya?\n"
    @player.pioneer_types.each_with_index do |pt, i|
      print "  #{i+1}: #{pt}\n"
    end

    type = nil
    while type.nil?
      print prompt
      type_index = gets.chomp.to_i
      type = @player.pioneer_types[type_index-1] rescue nil
      if type.nil?
        puts "You been drinkin' too much Whiskey young feller, yer not makin' any sense! Try again!"
      end
    end
    @player.type = type
  end

  def get_cards
    print "A #{@player.type}, eh? You look to skinny to be a #{@player.type}, but whatever you say!\n"
    print "Let's have a look at those cards...\n\n"
    (1..6).each do |i|
      card = get_card
      @player.cards << card
      print "\nAll right, thats a #{card.value} point #{card.name}. "
      puts "Lets have a look at the next one...\n\n" if i != 6
    end
  end

  def get_card
    card = get_card_type
    card.name = get_card_name(card)
    card.value = get_card_value(card)
    card
  end

  def get_card_type
    card = Card.new
    print "What sort of card do you have?\n"
    card.print_options
    type = nil
    while type.nil?
      print prompt
      type_index = gets.chomp.to_i
      type = card.allowed_names[type_index-1] rescue nil
      if type.nil?
        puts "You been drinkin' too much Whiskey young feller, yer not makin' any sense! Try again!"
      end
    end
    Card.get_instance_from_type(type)
  end

  def get_card_name(card)
    print "What kind of #{card.class} do you have?\n"
    card.print_options
    name = nil
    while name.nil?
      print prompt
      type_index = gets.chomp.to_i
      name = card.allowed_names[type_index-1] rescue nil
      if name.nil?
        puts "You been drinkin' too much Whiskey young feller, yer not makin' any sense! Try again!"
      end
    end
    name
  end

  def get_card_value(card)
    print "\nWhat is the point value on the card: "
    gets.chomp.to_i
  end

  def prompt
    "\n> "
  end

  def summarize_cards(player)
    puts "\n\n******************"
    puts "**  Your Cards  **"
    puts "******************"

    puts player.cards


  end


  def display_score(player)
    player.display_score
  end

  def spin_yarn(player)



  end


end
