require 'cancancan'
require 'simple_form'
require 'acts_as_list'
require 'mini_magick'
require 'carrierwave'

require 'bizarroids/slider/engine'
require 'bizarroids/slider/config_error'
require 'bizarroids/slider/media_uploader'

module Bizarroids
  module Slider
    # name prefix for ActiveRecord
    def self.table_name_prefix
      'bizarroids_slider_'
    end

    DEFAULT_SLIDE_ATTRIBUTES = %i(name description media link).freeze

    def self.get key
      Collection.actual.find_by!(key: key).slides
    end

    class << self
      alias :[] :get
    end

    mattr_accessor :collections
    @@collections = {}

    mattr_accessor :keys
    @@keys = []

    mattr_accessor :slide_attributes
    @@slide_attributes = %i(name description media link)

    mattr_accessor :slide_require_attributes
    @@slide_require_attributes = %i(name)

    mattr_accessor :files_storage_dir
    @@files_storage_dir = 'system/slider/'

    mattr_accessor :extension_white_list
    @@extension_white_list = %w(jpg jpeg gif png)

    mattr_accessor :parent_controller
    @@parent_controller = '::ApplicationController'

    mattr_accessor :use_cancancan
    @@use_cancancan = true

    def self.setup
      yield self
    end

    private

    def self.collection key, attrs={}
      key = key.to_sym
      attrs = attrs.dup

      if keys.include? key
        raise ConfigError.new "Collection ':#{key}' already exists"
      end

      collections[key] = attrs
      keys << key

      # skip creating if table is not exists
      return unless ActiveRecord::Base.connection.table_exists? Collection.table_name

      attrs[:position] = keys.index(key)

      collection = Collection.find_by key: key

      if collection.present?
        collection.update_attributes attrs.slice(*update_attr_names)
      else
        collection = Collection.create! attrs.merge(key: key).slice(*valid_attr_names)
      end

      collection
    end

    def self.valid_attr_names
      %i(key name description position)
    end

    def self.update_attr_names
      valid_attr_names - %i(key)
    end
  end
end
