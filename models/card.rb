class Card
  attr_accessor :name, :value, :allowed_names

  def initialize
    self.allowed_names = ["Bonus", "Tool", "Land", "Resource", "Beast"].sort
  end

  def print_options
    allowed_names.each_with_index do |name, i|
      print "  #{i+1}: #{name}\n"
    end
  end

  def self.get_instance_from_type(type)
    case type
    when "Bonus"
      Bonus.new
    when "Tool"
      Tool.new
    when "Land"
      Land.new
    when "Resource"
      Resource.new
    when "Beast"
      Beast.new
    else
      raise "Unknown Card Type"
    end
  end

  def to_s
    "#{self.value} point #{self.name} (#{self.class})"
  end


end
