# Usage: ruby splitter.rb <YAML_CONFIGURATION_FILE> <SOURCE_TEST_DIRECTORY> <DESTINATION_TEST_DIRECTORY>
# i.e. ruby splitter.rb configurations.yaml ./tests split_testcase_dir

# This file will create multiple files out of one test case file.
# Each newly created file will have the unqiue browser / os combination read from the yaml file.

require 'yaml'

configurations = YAML.load_file(ARGV[0])

sourceDir = ARGV[1]
destinationDir = ARGV[2]

Dir.foreach(sourceDir) do |file|
	for config in configurations

	  next if not file.include? '.js'

	  newFileName = "#{file}_#{config['platform']}_#{config['browserName']}_#{config['version']}".gsub(' ', '').gsub('.js', '') + '.js'
	  puts "new file name will be : #{newFileName}"

	  configJSONStr = config.to_s.gsub('=>', ': ')

	  filePath = File.join(sourceDir, file)

	  newDesiredCaps = "desiredCapabilities: #{configJSONStr}"
	  content = File.read(filePath).gsub(/desiredCapabilities: \{[\sa-zA-Z:",0-9\[\]]*}/, newDesiredCaps)

	  Dir.mkdir(destinationDir) if not Dir.exists? destinationDir
	  destinationFile = File.join(destinationDir, newFileName)

	  File.open(destinationFile, 'w') { |file| file.write(content) }
	end

end
