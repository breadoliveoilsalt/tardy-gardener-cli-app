class TardyGardener::CLI

  def call
    welcome
    create_vegetable_objects(veg_basic_data)

  end

  def welcome
    puts <<~HEREDOC


        Welcome to Tardy Gardener!


        Please wait while data is loading...


        HEREDOC
  end

  def create_vegetable_objects(initial_data_array)
    initial_data_array.each do | veg_info |
      TardyGardener::Vegetable.new(veg_info)
    end
    add_descriptions_to_vegetable_objects
    #add_maturity_date_to_vegetable_objects
      #need to add this last one
  end

  def veg_basic_data
    TardyGardener::VegScraper.scrape_veg_basics
  end

  def add_descriptions_to_vegetable_objects
    TardyGardener::VegScraper.scrape_veg_descriptions
  end


end
