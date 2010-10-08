class Tool < Card
  def initialize
    self.allowed_names = ["Lasso", "Pickaxe", "Plow", "Traps"]
  end

  # Each Pioneer can only use their tool
  #
  #  * Cowboy: Lasso
  #  * Prospector: Pickaxe
  #  * Homesteader: Plow
  #  * Trapper: Traps
  def self.appropriate_pioneer_name_for(tool_name)
    case tool_name
    when "Lasso"
      "Cowboy"
    when "Pickaxe"
      "Prospector"
    when "Plow"
      "Homesteader"
    when "Traps"
      "Trapper"
    end
  end


  def self.proper_tool_for_player(player)
    case player.type
    when "Cowboy"
      "Lasso"
    when "Prospector"
      "Pickaxe"
    when "Homesteader"
      "Plow"
    when "Trapper"
      "Traps"
    end
  end




end

