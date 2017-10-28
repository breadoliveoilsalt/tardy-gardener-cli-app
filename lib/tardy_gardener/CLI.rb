class TardyGardener::CLI

  attr_accessor :start_num, :display_amount, :end_num
      # consider changing to display_start, display_increment, display_end

  def initialize
    @start_num = 1
    @display_amount = 14
    @end_num = nil
  end

  def call
    welcome
    reset_vegetable_objects
    create_and_populate_vegetable_objects
    display_vegetables
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
    #uncomment later -- TardyGardener::VegScraper.scrape_veg_summary_etc
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

  def display_vegetables

    @end_num = determine_end_num

    puts "\n\nVegetable List:\n\n "

    while @start_num <= @end_num
      puts "\t #{@start_num}. #{all_veg[@start_num - 1].name}"
      @start_num = @start_num + 1
    end

    list_options

  end

  def list_options

    if @end_num < veg_count
      puts <<~HEREDOC

      -------------------------------------

      ** To see basic information about a particular vegetable, type in the vegetable's number.

      ** To see more vegetables, type 'm'.

      ** To repeat the current vegetable list, type 'r'.

      ** To exit, type 'exit.'

      -------------------------------------

        HEREDOC

    elsif @end_num == veg_count
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

#reformat this eventually to mirror options above
    if input == "r"
      @start_num = @start_num - @display_amount - 1
      display_vegetables
    elsif input == "m"
      restart_or_continue_list?
    elsif input == "b" && start_num != display_amount + 1
      display_vegetables(start_num - (display_amount*2) - 2 )
    elsif input.to_i.between?(1, veg_count)
      display_summary(input, start_num, end_num)
    elsif input == "exit"
      goodbye
    else
        puts "\n*********Sorry, I don't understand that.*********\n"
        list_options(start_num, end_num)
    end

  end

  def restart_or_continue_list?
    if @end_num == veg_count
      @start_num = 1
      display_vegetables
    else
      display_vegetables
    end
  end

  def display_summary(input, start_num, end_num)
    index = input.to_i - 1
    puts "\n\n#{all_veg[index].name}:  #{all_veg[index].summary}\n\n"
    list_options(start_num, end_num)
  end

  def determine_end_num
    if @start_num + @display_amount < veg_count
      @start_num + @display_amount
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
