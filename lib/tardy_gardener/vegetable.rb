class TardyGardener::Vegetable

  @@all = [ ]

  attr_accessor :name, :light, :sprouting_time, :maturity_date, :summary, :url_basic_info, :url_variety_info

    # If building this out in the future: Note that there are instance variables here that are not
    # currently used in the cli display -- for example, :url_variety_info and :maturity_date
    # (the former is to be used to scrape the latter).  The original goal here was to build something that
    # would tell you when certain plants would be ready for harvest, based on adding up :sprouting_time and
    # :maturity_date.  This is why each of the vegetable instances needed all of this information.
    # For now, I left the cli display as-is, providing only a summary of the plant, light-level,
    # and sprouting time.  :url_variety_info and :maturity_date aren't used, but I left them here for the future.

  def initialize(veg_hash)
    veg_add_data(veg_hash)
    save
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def veg_add_data(veg_hash)
    veg_hash.each do | veg_key, veg_value |
      self.send("#{veg_key}=", veg_value)
    end
  end

  def self.reset!
    @@all.clear
  end

end
