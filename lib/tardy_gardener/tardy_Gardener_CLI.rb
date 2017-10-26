class TardyGardener::TardyGardenerCLI

  def initialize
  end

  def call
    puts "Welcome to Tardy Gardener!"
    hash_veg_basic_data = TardyGardener::VegScraper.scrape_veg_basics
    create_veg(hash_veg_basic_data)

  end

  def create_veg(data)
    data.each do | veg_info |
      Vegetable.new(veg_info)
    end
  end


  #create_veg(veg_basic_data)

  #def create_veg(data)

end
