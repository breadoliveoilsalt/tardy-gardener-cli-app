class TardyGardener::CLI

  attr_accessor :list_start_num, :display_amount

  def initialize
    @list_start_num = 1
    @display_amount = 15
  end

  def call
    welcome
    reset_vegetable_objects
    create_and_populate_vegetable_objects
    list_vegetables
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

  def list_vegetables

    puts "\n\nVegetable List:\n\n "

    counter = self.list_start_num
      #change to: list_start_num = #display_start

    while counter <= list_end_num
      puts "\t #{counter}. #{all_veg[counter - 1].name}"
      counter += 1
    end

    list_options

  end

  def list_options

    if self.list_start_num == 1
      puts <<~HEREDOC

      -------------------------------------

      ** To see basic information about a particular vegetable, type in the vegetable's number.

      ** To see more vegetables, type 'm'.

      ** To repeat the current vegetable list, type 'r'.

      ** To exit, type 'exit.'

      -------------------------------------

        HEREDOC

    elsif list_end_num == veg_count
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

    get_user_input

  end

  def get_user_input

    print ">> "
    input = gets.strip.downcase
    puts "\n-------------------------------------"

    if input.to_i.between?(1, veg_count)
      display_summary(input)
    elsif input == "m"
      continue_or_restart_list?
    elsif input == "b" && self.list_start_num != 1
      list_go_back
    elsif input == "r"
      list_vegetables
    elsif input == "exit"
      goodbye
    else
        puts "\n*********Sorry, I don't understand that.*********\n"
        list_options
    end

  end

  def continue_or_restart_list?
    if list_end_num == veg_count
      self.list_start_num = 1
      list_vegetables
    else
      self.list_start_num = self.list_start_num + self.display_amount
      list_vegetables
    end
  end

  def list_go_back
    self.list_start_num = self.list_start_num - self.display_amount
    list_vegetables
  end

  def display_summary(input)
    index = input.to_i - 1
    puts "\n\n#{all_veg[index].name}:  #{all_veg[index].summary}\n\n"
    list_options
  end

  def list_end_num
    if self.list_start_num + self.display_amount - 1 < veg_count
      self.list_start_num + self.display_amount - 1
    else
      veg_count
    end
  end

  def goodbye
    puts "\n\n***** Thanks for stopping by! :) *****\n\n\n"
    exit
  end

end #class end
