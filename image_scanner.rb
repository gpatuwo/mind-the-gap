require 'rubygems'
require 'nokogiri'
require 'open-uri'
require_relative 'updated_image'

class ImageScanner
  attr_reader :images

  def initialize(url)
    find_images(url)
    @updated_images = []
  end

  def find_images(url)
    webpage = Nokogiri::HTML(open(url))
    @images = webpage.css('img')
    update_images
  end

  def update_images
    @images.each do |image|
      UpdatedImage.new(image)
      puts "hello"
    end
  end

  def each(&prc)
    (0..@images.length).each do |image|
      prc.call(image)
    end
    @images
  end
end
