require_relative "image_finder.rb"
require "google/cloud/vision"
require 'googleauth'
require "google/apis/storage_v1"

class ImageRecognition

  def self.get_scopes_and_authorization

    scopes = ['https://www.googleapis.com/auth/cloud-platform', 'https://www.googleapis.com/auth/devstorage.read_only']
    authorization = Google::Auth.get_application_default(scopes)

    storage = Google::Apis::StorageV1::StorageService.new
    storage.authorization = authorization

  end

  def self.detect_text(image_path)

    # [START vision_text_detection]
    # project_id = "Your Google Cloud project ID"
    # image_path = "Path to local image file, eg. './image.png'"

    #get_scopes_and_authorization
    project_id = 'accessibility-167719'
    vision = Google::Cloud::Vision.new project: project_id
    puts vision
    puts "\n"

    #performs text detection, I think??
    #need to find character limit
    text = vision.image(image_path).text

    puts text
  end

  def self.detect_text_gcs project_id:, image_path:

    #get_scopes_and_authorization

    vision = Google::Cloud::Vision.new project: project_id
    image = vision.image image_path

    puts image.text

  end

  def self.detect_labels(img_src)

    ImageRecognition.get_scopes_and_authorization

    # Your Google Cloud Platform project ID
    project_id = 'accessibility-167719'
    #project_id = '2e03176f6932eb9ce9318d5449e167d772f94a3a'
    # Instantiates a client
    vision = Google::Cloud::Vision.new project: project_id

    # The name of the image file to annotate
    file_name = img_src

    # Performs label detection on the image file
    labels = vision.image(file_name).labels

    puts "Labels:"
    labels.each do |label|
      puts label.description
    end

  end

end

if __FILE__ == $PROGRAM_NAME
  image_path = ARGV.shift
  project_id = ENV['accessibility-167719']

  if image_path
    ImageRecognition.detect_labels image_path: image_path, project_id: project_id
  else
    puts <<-usage
    Usage: ruby detect_text.rb [image file path]
    Example:
    ruby detect_text.rb image.png
    ruby detect_text.rb https://public-url/image.png
    ruby detect_text.rb gs://my-bucket/image.png
    usage
  end
end
