class TardyGardener::CLI

  attr_accessor :start_num, :display_amount#, :end_num
      # consider changing to list_start_num, display_increment, List_end_num

  def initialize
    @start_num = 1
    @display_amount = 15
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

    puts "\n\nVegetable List:\n\n "

    counter = self.start_num
      #change to: start_num = #display_start

    while counter <= end_num
      puts "\t #{counter}. #{all_veg[counter - 1].name}"
      counter += 1
    end

    list_options

  end

  def list_options

    if self.start_num == 1
      puts <<~HEREDOC

      -------------------------------------

      ** To see basic information about a particular vegetable, type in the vegetable's number.

      ** To see more vegetables, type 'm'.

      ** To repeat the current vegetable list, type 'r'.

      ** To exit, type 'exit.'

      -------------------------------------

        HEREDOC

    elsif end_num == veg_count
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

#reformat this eventually to mirror options above
    if input == "r"
      display_vegetables
    elsif input == "m"
      continue_or_restart_list?
    elsif input == "b" && self.start_num != 1
      list_go_back
    elsif input.to_i.between?(1, veg_count)
      display_summary(input)
    elsif input == "exit"
      goodbye
    else
        puts "\n*********Sorry, I don't understand that.*********\n"
        list_options
    end

  end

  def continue_or_restart_list?
    if end_num == veg_count
      self.start_num = 1
      display_vegetables
    else
      self.start_num = self.start_num + self.display_amount
      display_vegetables
    end
  end

  def list_go_back
    self.start_num = self.start_num - self.display_amount
    display_vegetables
  end

  def display_summary(input)
    index = input.to_i - 1
    puts "\n\n#{all_veg[index].name}:  #{all_veg[index].summary}\n\n"
    list_options
  end

  def end_num
    if self.start_num + self.display_amount - 1 < veg_count
      self.start_num + self.display_amount - 1
    else
      veg_count
    end
  end

  def goodbye
    puts "\n\n***** Thanks for stopping by! :) *****\n\n\n"
    exit
  end

end #class end
