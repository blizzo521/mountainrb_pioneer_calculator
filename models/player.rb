class Player
  attr_accessor :name, :cards, :type, :pioneer_types, :gender

  def initialize
    self.pioneer_types = ["Prospector", "Homesteader", "Cowboy", "Trapper"].sort
    self.cards = []
  end
  
  def pronoun
    if gender == "Female"
      "she"
    elsif gender == "Male"
      "he"
    end
  end

  def possessive_pronoun
    if gender == "Female"
      "her"
    elsif gender == "Male"
      "his"
    end
  end

  def display_score
    puts "\n******************"
    puts "**  Your Score  **"
    puts "******************"
      
    resource_score = calculate_resources
    bonus_score = calculate_bonuses

    puts "Resource Subtotal: #{resource_score}"
    puts "Bonus Subtotal: #{bonus_score}\n"
    puts "* Total Score: #{resource_score + bonus_score}"
  end


  # helpers for calculating edge cases
  def is_allowed_to_use_tool?(tool)
    type == Tool.appropriate_pioneer_name_for(tool)
  end

  def has_proper_tool?
    tools.map(&:name).include?(Tool.proper_tool_for_player(self))
  end

  def has_proper_tool_for_resource?(resource)
    has_tool?(resource.appropriate_tool_name)
  end

  def only_has_mountains?
    !lands.empty? && (lands.select{|land|land.name == "Mountain"} == lands.size)
  end

  def has_any_mountains?
    !lands.empty? && lands.select{|land|land.name == "Mountain"}.any?
  end

  def is_a_homesteader?
    type == "Homesteader"
  end
  
  def is_a_horseless_cowboy?
    type == "Cowboy" && beasts.select{|b|b.name == "Horse"}.empty?
  end

  # helpers to get subsets of certain types of cards
  def resources
    @resources ||= cards.select{|card|card.is_a?(Resource)}
  end
  def tools
    @tools ||= cards.select{|card|card.is_a?(Tool)}
  end
  def bonuses
    @bonuses ||= cards.select{|card|card.is_a?(Bonus)}
  end
  def beasts
    @beasts ||= cards.select{|card|card.is_a?(Beast)}
  end
  def lands
    @lands ||= cards.select{|card|card.is_a?(Land)}
  end

  private

  def calculate_bonuses
    bonus_score = 0
    scores = cards.select{|c|c if c.class == Bonus}.map{|c|c.value}
    scores.each{|score|bonus_score += score}
    bonus_score
  end

  def calculate_resources
    resource_score = 0
    resource_cards = cards.select{|c|c if c.class != Bonus}
    resource_cards.each do |rcard|
      modified_score_for_card = modified_value_for(rcard)
      resource_score += modified_score_for_card
    end
    resource_score
  end

  def modified_value_for(rcard)
    if rcard.class == Land
      modified_land_value_for(rcard)
    elsif rcard.class == Tool
      is_allowed_to_use_tool?(rcard.name) ? rcard.value : 0
    elsif rcard.class == Resource
      return 0 if is_a_horseless_cowboy?
      if has_proper_tool_for_resource?(rcard) && is_allowed_to_use_tool?(rcard.appropriate_tool_name)
        rcard.value
      else
        0
      end
    elsif rcard.class == Beast
      modified_beast_value_for(rcard)
    end
  end

  def modified_beast_value_for(beast)
    beast.modified_value_for_player(self)
  end


  # it seems reasonable that the pioneer would only use their resource on the best land
  # option available, so take the highest modifier and throw away the lower ones
  #   - if you have no resource, you shouldnt get any value from your land, so
  #     just return 0 if there arent any
  #   - always include a 0 modifier in the list in case the player doesnt
  #     have any legally usable resources to exploit the land
  #   - the example shows that modified values are rounded down, so do that
  def modified_land_value_for(land)
    return 0 if resources.empty?

    land_base_value = land.value
    modifiers = [0.0]

    resources.each do |resource|
      modifiers << land.modifier_for_resource(resource.name) if has_proper_tool_for_resource?(resource) && is_allowed_to_use_tool?(resource.appropriate_tool_name)
    end

    modifier = modifiers.sort.last
    (land_base_value*modifier).to_i
  end


  # helpers to see if you have a specifically named card of a known type
  def has_resource?(resource_name)
    resources.select{|r|r.name == resource_name}.any?
  end
  def has_tool?(tool_name)
    tools.select{|t|t.name == tool_name}.any?
  end
  def has_beast?(beast_name)
    beasts.select{|b|b.name == beast_name}.any?
  end
  def has_land?(land_name)
    lands.select{|l|l.name == land_name}.any?
  end


end
