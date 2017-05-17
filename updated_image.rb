require 'rubygems'
require 'nokogiri'
require 'open-uri'

class ImageUpdater
  attr_reader :updated_image, :alt_text
  def initialize(image)
    @image = image
  end

  def self.update_image(image)
    img_src = image.attributes['src'].value
    reverse_img_search_url = 'https://www.google.com/searchbyimage?&image_url=${img_src}'
    results_page = Nokogiri::HTML(open(reverse_img_search_url))
    alt_text = results_page.css('div._hUb')
    puts alt_text
  end

  def get_alt_text(page)
    @alt_text = page.css('div._hUb')
    puts @alt_text
  end
end
#http://www.boxingscene.com/newimgs/Untitled-2copy.png
#http://www.boxingscene.com/ufc-white-sets-deadline-on-mayweather-vs-mcgregor-fight--116492
