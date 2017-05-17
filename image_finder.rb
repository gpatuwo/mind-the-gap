require 'rubygems'
require 'nokogiri'
require 'open-uri'
require_relative 'updated_image'

class ImageFinder
  attr_reader :images

  def initialize url
    @images = find_images url
  end

  def find_images url
    webpage = Nokogiri::HTML open url
    webpage.css 'img'
  end

  def update_images
    @images.each do |image|
      ImageUpdater.new image
      puts "hello"
    end
  end

  def each &prc
    (0..@images.length).each do |image|
      prc.call(image)
    end
    @images
  end
end
