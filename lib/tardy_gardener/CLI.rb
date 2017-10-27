class TardyGardener::CLI

  def call
    welcome
    create_and_populate_vegetable_objects
    display_vegetables(1)
  end

  def welcome
    puts <<~HEREDOC


        Welcome to Tardy Gardener!


        Please wait while data is loading...
        HEREDOC
  end

  def create_and_populate_vegetable_objects
    veg_create_objects(basic_data)
    TardyGardener::VegScraper.scrape_veg_summary_etc
    # Add last scraping here
  end

  def veg_create_objects(data)
    data.each do | veg_hash |
      TardyGardener::Vegetable.new(veg_hash)
    end
  end

  def basic_data
    TardyGardener::VegScraper.scrape_veg_basics
  end

  def all_veg
    TardyGardener::Vegetable.all
  end

  def display_vegetables(start_num)

    end_num = find_end_num(start_num)

    puts "\n\nHere is a list of vegetables:\n\n "

    while start_num <= end_num
      puts "\t #{start_num}. #{all_veg[start_num - 1].name}"
      start_num += 1
    end
      binding.pry

    puts <<~HEREDOC

      To see more vegetables, type 'more'."

      To see basic information about a particular vegetable, type in the vegetable's number.

        HEREDOC


    print ">> "
    input = gets.strip.downcase

    if input == "more"
      end_num == all_veg.count ? display_vegetables(1) : display_vegetables(start_num)
    elsif input.to_i.between?(1, all_veg.count)
      index = input.to_i - 1
      puts "\n\n#{all_veg[index].name}:  #{all_veg[index].summary}\n\n"
    end

  end

  def find_end_num(start_number)
    if start_number + 14 < all_veg.count
      start_number + 14
    else
      all_veg.count
    end
  end

end
