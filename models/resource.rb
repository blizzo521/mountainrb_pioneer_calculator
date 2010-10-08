# resouces are things that are paired with land (ore, seeds, etc)
class Resource < Card
  def initialize
    self.allowed_names = ["Ore Vein","Seeds","Wild Game","Cattle"]
  end

  # Tools are paired with resource
  #
  #  * Lasso: Cattle
  #  * Pickaxe: Ore Vein
  #  * Plow: Seeds
  #  * Traps: Wild Game
  def appropriate_tool_name
    case name
    when "Ore Vein"
      "Pickaxe"
    when "Seeds"
      "Plow"
    when "Wild Game"
      "Traps"
    when "Cattle"
      "Lasso"
    end
  end


end
