class Bonus < Card
  def initialize
    self.allowed_names = ["Rifle", "Opera House", "Circus", "Whiskey", "Guitar", "Railroad"].sort
  end
end
