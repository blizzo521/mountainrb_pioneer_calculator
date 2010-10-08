class YarnSpinner
  def initialize(player)
    @player = player
    spin
  end

  def spin
    header
    intro
    career
    life
    conclusion
  end

  def header
    puts "\n\n******************"
    puts "**  Your Story  **"
    puts "******************"
  end

  def intro
    print "#{@player.name} was a #{adjective1} #{adjective2} #{@player.type} from #{location}. "
  end

  def career
    if @player.has_proper_tool?
      print "#{@player.name} spent all their years meandering around in the #{@player.lands.empty? ? "aimlessly" : @player.lands.first.plural_name}"
      if @player.beasts.empty?
        print ". "
      else
        print " with their #{@player.beasts.first.name.downcase}. "
      end
    else
      print "#{@player.name} was so bad at their job, they didn't even have a #{Tool.proper_tool_for_player(@player)}."
    end
  end

  def life
    print "When #{@player.name} wasn't working, they spent all their time on "
    print to_sentence(@player.bonuses.map{|b|b.name}.uniq)
    print ". "
    if @player.bonuses.select{|b|b.name == "Whiskey"}.size > 2
      print "In fact, they liked Whiskey so much, one time they "
      print drunk_desc
    end
  end

  def conclusion
    print " In the end, #{@player.name} was #{liked_or_not}\n\n\n"
  end
  
  private

  def liked_or_not
    @liked ||= ["well liked. ",
                "liked about as much as a goathead on a toilet seat. ",
                "hated throughout the land. ",
                "pretty much the swellest pioneer in town. "
                ]
    @liked[rand(@liked.size)]
  end

  def drunk_desc
    @drunk ||= ["tried to make out with the stuffed moose head in the tavern.",
                "used the bar piano as an outhouse.",
                "asked the priest to marry them to a horseshoe.",
                "considered using Java instead of Ruby."
                ]
    @drunk[rand(@drunk.size)]
  end
  
  def adjective1
    @adj1 ||= %w(silly funny ugly handsome freaky gassy nerdy geeky loud funky sickly wonderful reprehensible sexy)
    @adj1[rand(@adj1.size)]
  end

  def adjective2
    @adj2 ||= %w(old little young)
    @adj2[rand(@adj2.size)]
  end

  def location
    @loc ||= ["Denver, CO", "Boulder, CO", "Cincinatti, OH", "England", "Salt Lake City, UT", "Deadwood, SD", "New York, NY", "Austin, TX", "San Francisco, CA"]
    @loc[rand(@loc.size)]
  end

  def to_sentence(array)
    if array.size == 1
      array.first
    elsif array.size == 2
      array.join " and "
    else
      str = ""
      array.each do |ele|
        str << ele
        if ele != array.last
          if ele != array[array.size-2]
            str << ", "
          else
            str << " and "
          end
        end
      end
      str
    end
  end

end
