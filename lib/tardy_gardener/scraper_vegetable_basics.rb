class TardyGardener::ScraperVegBasics

  def initialize
  end

  def get_doc
    doc = Nokogiri::HTML(open("http://www.gardening.cornell.edu/homegardening/scene0391.html"))
    puts doc
  end


end
