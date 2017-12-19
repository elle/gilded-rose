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
