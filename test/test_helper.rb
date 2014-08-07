# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class ActiveSupport::TestCase
  def clean_collections
    Bizarroids::Slider::Collection.destroy_all
    Bizarroids::Slider.collections.clear
    Bizarroids::Slider.keys.clear
  end

  def create_home_slider
    clean_collections
    Bizarroids::Slider.setup do |config|
      config.collection :home_page_slider
    end
  end
end

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end
