class TardyGardener::CLI

  attr_accessor :display_start_num, :display_end_num

  # def initialize
  #   @display_start_num = 1
  #   @display_end_num = find_end_num(@display_start_num)
  #   binding.pry
  # end

  def call
    welcome
    create_and_populate_vegetable_objects
      # numbers to display to user are based on the #count of Vegetables::all, so need that to load first
      # before instance variables @display_start_num and @display_end_num can be set
    set_display_start_and_end_numbers
    display_vegetables(display_start_num)
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

  def display_vegetables(display_start_num)

    display_end_num = find_end_num(display_start_num)

    puts "\n\nHere is a list of vegetables:\n\n "

    while display_start_num <= display_end_num
      puts "\t #{display_start_num}. #{all_veg[display_start_num - 1].name}"
      display_start_num += 1
    end

    puts <<~HEREDOC

      To see more vegetables, type 'more'."

      To see basic information about a particular vegetable, type in the vegetable's number.

        HEREDOC


    input = gets.strip.downcase

    if input == "more"
      display_end_num == all_veg.count ? display_vegetables(1) : display_vegetables(display_start_num)
    elsif input.to_i.between?(1, all_veg.count)
      index = input.to_i - 1
      puts all_veg[index].url_basic_info

    end
  end

  def set_display_start_and_end_numbers
    @display_start_num = 1
    @display_end_num = find_end_num(@display_start_num)
  end

  def find_end_num(start_number)
    if start_number + 14 < all_veg.count
      start_number + 14
    else
      all_veg.count
    end
  end



end
