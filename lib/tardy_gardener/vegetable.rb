class TardyGardener::Vegetable

  @@all = [ ]

  attr_accessor :name, :light, :sprouting_time, :maturity_date, :summary, :url_basic_info, :url_variety_info

  def initialize(name = nil)
    @name = name

  end

end
