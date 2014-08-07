require 'test_helper'
require 'generators/bizarroids/slider/install/install_generator'

class Bizarroids::Slider::InstallGeneratorTest < Rails::Generators::TestCase
  tests Bizarroids::Slider::InstallGenerator
  destination Rails.root.join('tmp/generators')
  setup do
    prepare_destination
    copy_routes
  end

  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator ["arguments"]
    end
  end

  test "generator creates files" do
    run_generator
    #assert_file 'config/initializers/bizarroids_slider.rb'
    #assert_file "config/locales/bizarroids_slider.en.yml"
    #assert_file "config/locales/bizarroids_slider.ru.yml"
    #assert_migration 'db/migrate/*create_bizarroids_slider_tabless.rb'
  end

  def copy_routes
    routes = File.expand_path("config/routes.rb", Rails.root)
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, destination
  end
end
