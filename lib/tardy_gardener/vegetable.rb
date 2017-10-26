class TardyGardener::Vegetable

  @@all = [ ]

  attr_accessor :name, :light, :sprouting_time, :maturity_date, :summary, :url_basic_info, :url_variety_info

  def initialize(veg_hash)
    veg_hash.each do | veg_key, veg_value |
      self.send("#{veg_key}=", veg_value)
    end
    save
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

end
