class TardyGardener::CLI

  attr_accessor :display_start_num, :display_end_num

  # can't initialize with these b/c numbers are dependent on all_veg.count...so veg objects need to populate first
  # def initialize
  #    @display_start_num = 1
  #    @display_end_num = find_end_num(self.display_start_num)
  # end

  def call
    welcome
    create_and_populate_vegetable_objects
      # numbers to display to user are based on the #count of Vegetables::all, so need that to load first
      # before instance variables @display_start_num and @display_end_num can be set
    set_display_start_and_end_numbers
#    puts display_start_num
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
    # TardyGardener::VegScraper.scrape_veg_summary_etc
    # UNCOMMENT LATER/COMMENTING-OUT TO SAVE TIME:    veg_add_summary_etc

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

  def display_vegetables(display_start_num)

    self.display_end_num = find_end_num(display_start_num)

    puts "\n\nHere is a list of vegetables:\n\n "

    while display_start_num <= display_end_num
      puts "\t #{display_start_num}. #{all_veg[display_start_num - 1].name}"
      self.display_start_num = self.display_start_num + 1
      #Ths main problem here is that this is not changing display_start_num permanently
    end
    binding.pry #But when I exit the pry, it is showing that display_end_num has increased.
    # Maybe make everything an @variable for now.  Also, put a binding.pry under list options to
    # See where you are.
    list_options

  end

  def list_options

    puts <<~HEREDOC

      To see more vegetables, type 'more'."

      To see basic information about a particular vegetable, type in the vegetable's number.

        HEREDOC


    input = gets.strip.downcase

    if input == "more"
      puts display_end_num
      #can do raise here to display end num and start num
      display_end_num == all_veg.count ? display_vegetables(1) : display_vegetables(display_start_num)
    elsif input.to_i.between?(1, all_veg.count)
      index = input.to_i - 1
      puts all_veg[index].url_basic_info
    end

  end

  def set_display_start_and_end_numbers
    @display_start_num = 1
    @display_end_num = find_end_num(self.display_start_num)
  end

  def find_end_num(start_number)
    if start_number + 14 < all_veg.count
      start_number + 14
    else
      all_veg.count
    end
  end

end
