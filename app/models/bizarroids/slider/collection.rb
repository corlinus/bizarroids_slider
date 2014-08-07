class Bizarroids::Slider::Collection < ActiveRecord::Base
  has_many :slides

  validates :key, presence: true, uniqueness: true

  scope :actual, -> { where key: Bizarroids::Slider.keys }
  default_scope -> { order :position }

  def to_param
    key
  end

  def to_key
    key.to_sym
  end

  def version_options
    config_options.fetch :versions, {}
  end

  def human_name
    name || key.humanize
  end

  def slide_attributes
    config_options.fetch :slide_attributes, Bizarroids::Slider.slide_attributes
  end

  def slide_require_attributes
    config_options.fetch :slide_require_attributes, Bizarroids::Slider.slide_require_attributes
  end

  private

  def config_options
    Bizarroids::Slider.collections[to_key]
  end
end
