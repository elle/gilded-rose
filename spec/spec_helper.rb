require "rspec"
require "simplecov"
require "simplecov-console"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console,
]

SimpleCov.start do
  add_filter "env.rb"
  add_filter "/spec/"
end

require_relative "../env"

RSpec.configure do |config|
  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end
