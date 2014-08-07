class Bizarroids::Slider::Slide < ActiveRecord::Base
  belongs_to :collection

  validates :collection, presence: true

  delegate :version_options, to: :collection

  ( Bizarroids::Slider::DEFAULT_SLIDE_ATTRIBUTES-[:media] ).each do |attr_name|
    validates attr_name, presence: true, if: "collection.slide_require_attributes.include? :#{attr_name}"
  end

  acts_as_list scope: :collection

  default_scope -> { order :position }

  mount_uploader :media, Bizarroids::Slider::MediaUploader
end
