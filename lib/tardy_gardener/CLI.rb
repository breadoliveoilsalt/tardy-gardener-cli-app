class TardyGardener::CLI

  attr_accessor :display_amount

  def initialize
    @display_amount = 14
  end

  def call
    welcome
    reset_vegetable_objects
    create_and_populate_vegetable_objects
    display_vegetables(1)
  end

  def welcome
    puts <<~HEREDOC


        Welcome to Tardy Gardener!


        Please wait while data is loading...
        HEREDOC
  end

  def reset_vegetable_objects
    TardyGardener::Vegetable.reset!
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

  def veg_count
    all_veg.count
  end

  def display_vegetables(start_num)

    end_num = determine_end_num(start_num)

    puts "\n\nVegetable List:\n\n "

    while start_num <= end_num
      puts "\t #{start_num}. #{all_veg[start_num - 1].name}"
      start_num += 1
    end

    list_options(start_num, end_num)

  end

  def list_options(start_num, end_num)

    if end_num == veg_count
      puts <<~HEREDOC

      -------------------------------------

      ** To see basic information about a particular vegetable, type in the vegetable's number.

      ** To restart the list of vegetables, type 'm'.

      ** To go back to the prior list, type 'b'.

      ** To repeat the current vegetable list, type 'r'.

      ** To exit, type 'exit.'

      -------------------------------------

        HEREDOC

    else
      puts <<~HEREDOC

      -------------------------------------

      ** To see basic information about a particular vegetable, type in the vegetable's number.

      ** To see more vegetables, type 'm'.

      ** To go back to the prior list, type 'b'.

      ** To repeat the current vegetable list, type 'r'.

      ** To exit, type 'exit.'

      -------------------------------------

        HEREDOC
    end

    print ">> "
    input = gets.strip.downcase
    puts ""
    puts "-------------------------------------"

    if input == "r"
      display_vegetables(start_num - display_amount - 1)
    elsif input == "m"
      restart_or_continue_list?(start_num, end_num)
    elsif input == "b"
      display_vegetables(start_num - (display_amount*2) -2 )
    elsif input.to_i.between?(1, veg_count)
      display_summary(input, start_num, end_num)
    elsif input == "exit"
      goodbye
    else
        puts "\n*********Sorry, I don't understand that.*********\n"
        list_options(start_num, end_num)
    end

  end

  def restart_or_continue_list?(start_num, end_num)
    end_num == veg_count ? display_vegetables(1) : display_vegetables(start_num)
  end

  def display_summary(input, start_num, end_num)
    index = input.to_i - 1
    puts "\n\n#{all_veg[index].name}:  #{all_veg[index].summary}\n\n"
    list_options(start_num, end_num)
  end

  def determine_end_num(start_num)
    if start_num + display_amount < veg_count
      start_num + display_amount
    else
      veg_count
    end
  end
  #
  # def display_amount
  #     14
  # end

  def goodbye
    puts "\n\n***** Thanks for stopping by! :) *****\n\n\n"
    exit
  end

  # def line_break
  #     puts "-------------------------------------"
  # end

end
