require 'test_helper'

module Bizarroids
  class SliderTest < ActiveSupport::TestCase
    test "is a module module" do
      assert_kind_of Module, Bizarroids::Slider
    end

    #
    # config
    #
    test 'setup block yields self' do
      Slider.setup do |config|
        assert_equal Slider, config
      end
    end

    test "creating option from config" do
      create_home_slider
      assert_equal Slider[:home_page_slider], []
    end

    test "Duplicate collection key raises an error" do
      clean_collections

      assert_raises Bizarroids::Slider::ConfigError do
        Slider.setup do |config|
          config.collection :home_page_slider
          config.collection :home_page_slider
        end
      end
    end

    #
    # get
    #
    test "respond to #get" do
      assert_respond_to Bizarroids::Slider, :get
    end

    test "respond to #[]" do
      assert_respond_to Bizarroids::Slider, :[]
    end

    test "get :key retuns collection" do
      create_home_slider
      assert_equal Bizarroids::Slider.get(:home_page_slider), []
    end

    #
    # misc
    #
    test 'table name prefix' do
      assert_equal Slider.table_name_prefix, 'bizarroids_slider_'
    end
  end
end
