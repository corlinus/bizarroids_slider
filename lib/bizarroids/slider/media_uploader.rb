# encoding: utf-8

class Bizarroids::Slider::MediaUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    File.join Bizarroids::Slider.files_storage_dir, model.collection.key, model.id.to_s
  end

  version :main do
    process process_variant: :main
  end

  version :thumb do
    process process_variant: :thumb
  end

  def extension_white_list
    Bizarroids::Slider.extension_white_list
  end

  private

  def process_variant variant_name
    if model && model.collection && file
      processors = model.version_options.fetch variant_name, {}

      processors.each do |method, args|
        self.send method, *args
      end
    end
  end
end
