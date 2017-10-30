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

  def self.scrape_veg_summary_etc
    TardyGardener::Vegetable.all.each do | vegetable |
      doc = Nokogiri::HTML(open(vegetable.url_basic_info))
      vegetable.summary = doc.css('.normal p')[2].text.gsub("\r\n", "")
      vegetable.light = self.get_vegetable_light(doc)
      vegetable.sprouting_time = doc.xpath('//p[contains(text(), "emergence")]').text.gsub(/[\r\n\t]/, "").split.detect { |i| i.to_i != 0 } || "Not available"
      vegetable.url_variety_info = doc.xpath('//a[contains(text(), "varieties")]/@href').text

    end
  end

  def self.get_vegetable_light(doc)
    query = doc.css('ul[type="square"]')[0].text.gsub(/[\r\t\n]/, "")
    if query == "full sunpart shade" || query == "part shadefull shade"
      "full sun or part shade"
    else
      query
    end
  end

end #class end
