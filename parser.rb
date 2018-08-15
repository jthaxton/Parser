require 'open-uri'
require 'nokogiri'

#for Craigslist

class Parser
  attr_accessor :doc, :arr
  attr_reader :root_link

  def initialize(root_link)
    @root_link = root_link
    @doc = Nokogiri::HTML(open(root_link).read)
    @arr = []
  end

  def doc
    @doc
  end

  def get_links
    @doc.css('ul.rows a').map {|link| @arr << link['href'] if link['href'] != '#'}
    p "Listing URLs... "
    p @arr[0..15]
  end

  def read_link(string)
    @doc.css('section#postingbody').each do |v|
      if v.content.include?(string)
        p "URL contains keyword? "
        p true
        p @root_link
      else
        p "URL contains keyword? "
        p false
      end

    end
  end

  def scrape(str)
    self.get_links.each do |v|
      Parser.new(v).read_link(str)
    end
  end


end

x = Parser.new('https://sfbay.craigslist.org/search/sof?')
x.scrape('cloud')
