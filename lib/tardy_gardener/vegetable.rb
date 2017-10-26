class TardyGardener::Vegetable

  @@all = [ ]

  attr_accessor :name, :light, :sprouting_time, :maturity_date, :summary, :url_basic_info, :url_variety_info

  def initialize(data)
    self.send("#{key}=",value)
    save
  end

  def self.all?
    @@all
  end

  def save
    all << self
  end

end
