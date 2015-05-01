require 'yaml'


configurations = YAML.load_file(ARGV[0])

sourceDir = ARGV[1]
destinationDir = ARGV[2]

for config in configurations
	# generate a new file in tests
	puts "\n\n"
	puts "browser is : #{config['browserName']}"


	# each js file in sourceDir, create a new browser

	Dir.foreach(sourceDir) do |file|
	  next if not file.include? '.js' # later check last character

	  # we have a js file, we want to create browser specific files
	  puts "file is #{file}"


	  newFileName = "#{file}_#{config['platform']}_#{config['browserName']}_#{config['version']}".gsub(' ', '').gsub('.js', '') + '.js'
	  puts "new file name will be : #{newFileName}"

	  # construct the new file
	  # require 'debugger'; debugger;

	  configJSONStr = config.to_s.gsub('=>', ': ')

	  filePath = File.join(sourceDir, file)

	  newDesiredCaps = "desiredCapabilities: #{configJSONStr}"
	  content = File.read(filePath).gsub(/desiredCapabilities: \{[\sa-zA-Z:",0-9\[\]]*}/, newDesiredCaps)

	  Dir.mkdir(destinationDir) if not Dir.exists? destinationDir
	  destinationFile = File.join(destinationDir, newFileName)

	  # write to file
	  File.open(destinationFile, 'w') { |file| file.write(content) }

	end

end
