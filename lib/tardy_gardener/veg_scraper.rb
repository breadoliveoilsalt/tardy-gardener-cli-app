class TardyGardener::VegScraper

  def self.scrape_veg_basics
    array_veg_data = [ ]
    doc = Nokogiri::HTML(open("http://www.gardening.cornell.edu/homegardening/scene0391.html")).css("div.intromuted a")
    doc.collect do | veg_element |
        veg_hash = { }
        veg_hash[:name] = veg_element.text
        veg_hash[:url_basic_info] = "http://www.gardening.cornell.edu/homegardening/#{veg_element['href']}"
        array_veg_data << veg_hash
    end
    array_veg_data
  end

  def self.scrape_veg_descriptions
    TardyGardener::Vegetable.all.each do | vegetable |
      doc = Nokogiri::HTML(open(vegetable.url_basic_info))
      binding.pry
    end
  end

  # This seems to have gotten them

  # list = x.css("div.intromuted a")
  # list.count has 61 -- got em
  #
  # This gives me the html -- will need to add to this
  #   list.first['href']
  #   list.first.name -- gives me the name



  # def get_doc
  #   doc =
  #   puts doc
  # end

  # first clue: class="intromuted" -- this looks like the first column
  #each column is a td valign="top" with a div class of "intromuted"


end
