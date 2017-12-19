PROJECT_ROOT = File.expand_path("..", __FILE__)
$LOAD_PATH << PROJECT_ROOT

Dir["lib/**/*.rb"].each { |f| require f }
