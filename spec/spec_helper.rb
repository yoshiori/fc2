$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'local_cache'

RSpec.configure do |config|
  config.after(:each) do
    LocalCache.all_clear
  end
end
