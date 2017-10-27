class TardyGardener::CLI

  def call
    welcome
    create_and_populate_vegetable_objects

  end

  def welcome
    puts <<~HEREDOC


        Welcome to Tardy Gardener!


        Please wait while data is loading...


        HEREDOC
  end

  def create_and_populate_vegetable_objects
    veg_create_objects(basic_data)
    veg_add_summary_etc
#    veg_add_maturity_info(data_level_3)
  end


  def veg_create_objects(data)
    data.each do | veg_hash |
      TardyGardener::Vegetable.new(veg_hash)
    end
  end

  def basic_data
    TardyGardener::VegScraper.scrape_veg_basics
  end

  def veg_add_summary_etc
    TardyGardener::VegScraper.scrape_veg_summary_etc
  end


end
