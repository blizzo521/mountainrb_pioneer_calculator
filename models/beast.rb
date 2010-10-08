class Beast < Card
  def initialize
    self.allowed_names = ["Horse", "Oxen", "Burrow"]
  end

  # Beasts of Burden
  # * Burro: 2x points in mountains
  # * Horse: 1/2 points in mountains
  # * Ox: 2x points for Homesteader
  # * Cowboy: Must have horse or loses all resource points
  def modified_value_for_player(player)
    case name
    when "Horse"
      player.only_has_mountains? ? value/2 : value
    when "Oxen"
      player.is_a_homesteader? ? value*2 : value
    when "Burrow"
      player.has_any_mountains? ? value*2 : value
    end
  end

end
