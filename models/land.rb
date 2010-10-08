class Land < Card
  def initialize
    self.allowed_names = ["Forest", "Plains", "Mountain"]
  end

  # Resources are enhanced by land but with modifications
  #   * Cattle: Full for plains, 1/2 for mountains, 0 for forest
  #   * Ore Vein: Full for mountains, 1/2 for forest, 0 for plains
  #   * Seeds: Full for plains, 1/2 for forest, 0 for mountains
  #   * Wild Game: Full for forest, 1/2 for mountain, 0 for plains
  def modifier_for_resource(resource_name)
    case resource_name
    when "Cattle"
      case name
      when "Forest"
        0.0
      when "Plains"
        1.0
      when "Mountain"
        0.5
      end
    when "Ore Vein"
      case name
      when "Forest"
        0.5
      when "Plains"
        0.0
      when "Mountain"
        1.0
      end
    when "Seeds"
      case name
      when "Forest"
        0.5
      when "Plains"
        1.0
      when "Mountain"
        0.0
      end
   when "Wild Game"
      case name
      when "Forest"
        1.0
      when "Plains"
        0.0
      when "Mountain"
        0.5
      end
    end
  end

end
