require("sinatra/activerecord")
require("rspec")
require("pg")
require("list")
require("todo")

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
    DB.exec("DELETE FROM tasks *;")
  end
end
