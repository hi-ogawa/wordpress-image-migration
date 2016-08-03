require 'open-uri'
require 'csv'
require 'Pathname'

def download
  image_urls =
    CSV.read('./missing_images.csv', headers: true)
    .map { |pair| pair[1] }
    .select { |url| !url.nil? }
    .map { |url| url.gsub(/\?.*/, '') }

  image_urls.each do |url|
    orig_url = url.gsub(
      %r{http://blog.odigo.travel/wp-content/uploads},
      'https://odigoblog.files.wordpress.com'
    )
    file_path = Pathname.new(url.match(/wp-content\/uploads\/(.*)/)[1])
    next if file_path.exist?
    `mkdir -p #{file_path.dirname}`
    puts "Downloading #{orig_url} ..."
    File.open(file_path, 'wb') do |file|
      open(orig_url) do |image|
        file.puts(image.read)
      end
    end
  end
end

download
