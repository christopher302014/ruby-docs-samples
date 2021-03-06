# Copyright 2016 Google, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def detect_safe_search project_id:, image_path:
  # [START vision_safe_search_detection]
  # project_id = "Your Google Cloud project ID"
  # image_path = "Path to local image file, eg. './image.png'"
  
  require "google/cloud/vision"

  vision = Google::Cloud::Vision.new project: project_id
  image  = vision.image image_path

  safe_search = image.safe_search

  puts "Adult:    #{safe_search.adult?}"
  puts "Spoof:    #{safe_search.spoof?}"
  puts "Medical:  #{safe_search.medical?}"
  puts "Violence: #{safe_search.violence?}"
  # [END vision_safe_search_detection]
end

# This method is a duplicate of the above method, but with a different
# description of the 'image_path' variable, demonstrating the gs://bucket/file
# GCS storage URI format.
def detect_safe_search_gcs project_id:, image_path:
  # [START vision_safe_search_detection_gcs]
  # project_id = "Your Google Cloud project ID"
  # image_path = "Google Cloud Storage URI, eg. 'gs://my-bucket/image.png'"
  
  require "google/cloud/vision"

  vision = Google::Cloud::Vision.new project: project_id
  image  = vision.image image_path

  safe_search = image.safe_search

  puts "Adult:    #{safe_search.adult?}"
  puts "Spoof:    #{safe_search.spoof?}"
  puts "Medical:  #{safe_search.medical?}"
  puts "Violence: #{safe_search.violence?}"
  # [END vision_safe_search_detection_gcs]
end

if __FILE__ == $PROGRAM_NAME
  image_path = ARGV.shift
  project_id = ENV["GOOGLE_CLOUD_PROJECT"]

  if image_path
    detect_safe_search image_path: image_path, project_id: project_id
  else
    puts <<-usage
Usage: ruby detect_safe_search.rb [image file path]

Example:
  ruby detect_safe_search.rb image.png
  ruby detect_safe_search.rb https://public-url/image.png
  ruby detect_safe_search.rb gs://my-bucket/image.png
    usage
  end
end
