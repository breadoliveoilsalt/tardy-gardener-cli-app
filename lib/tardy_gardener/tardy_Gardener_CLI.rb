class TardyGardener::TardyGardenerCLI

  def initialize
  end

  def call
    puts "Welcome to Tardy Gardener!"
    veg_basic_data = TardyGardener::VegScraper.scrape_veg

  end



  #create_veg(veg_basic_data)

  #def create_veg(data)

end
