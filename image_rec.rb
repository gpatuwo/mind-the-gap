require_relative "image_finder.rb"
require "google/cloud/vision"

class ImageRecognition

  def self.detect_text (project_id = 'accessibility-167719', image_path:)

    # [START vision_text_detection]
    # project_id = "Your Google Cloud project ID"
    # image_path = "Path to local image file, eg. './image.png'"

    vision = Google::Cloud::Vision.new project: project_id
    puts vision
    puts "\n"
    image = vision.image image_path

    puts image.text

  end

  def self.detect_text_gcs project_id:, image_path:

    vision = Google::Cloud::Vision.new project: project_id
    image = vision.image image_path

    puts image.text

  end

end

if __FILE__ == $PROGRAM_NAME
  image_path = ARGV.shift
  project_id = ENV["GOOGLE_CLOUD_PROJECT"]

  if image_path
    ImageRecognition.detect_text image_path: image_path, project_id: project_id
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
