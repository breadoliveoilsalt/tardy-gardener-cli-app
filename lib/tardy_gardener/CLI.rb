class TardyGardener::CLI

  def call
    welcome
    create_and_populate_vegetable_objects
    display_vegetables
  end

  def welcome
    puts <<~HEREDOC


        Welcome to Tardy Gardener!


        Please wait while data is loading...


        HEREDOC
  end

  def create_and_populate_vegetable_objects
    veg_create_objects(basic_data)
# UNCOMMENT LATER/COMMENTING-OUT TO SAVE TIME:    veg_add_summary_etc
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

  def all_veg
    TardyGardener::Vegetable.all
  end

  def display_vegetables(start_number = 1)
    end_number = find_end_number(start_number)
    puts "\n\nHere is a list of vegetables:\n\n "
    while start_number <= end_number
      puts "\t #{start_number}. #{all_veg[start_number - 1].name}"
      start_number += 1
    end

    puts "\nTo see more vegetables, type 'more'."
    input = gets.strip.downcase
    case input
    when "more"
      display_vegetables(start_number)
    end
  end

  def find_end_number(start_number)
    if start_number + 9 < all_veg.count
      start_number + 9
    else
      all_veg.count
    end
  end

end
