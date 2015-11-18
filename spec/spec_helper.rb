$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fc2'

RSpec.configure do |config|
  config.after(:each) do
    Fc2.all_clear
  end
end
