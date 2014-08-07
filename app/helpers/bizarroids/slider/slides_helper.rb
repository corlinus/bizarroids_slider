module Bizarroids::Slider::SlidesHelper
  def bizarroids_slider_form_submit_path
    if @slide.new_record?
      bizarroids_slider_engine.slider_collection_slides_path @collection
    else
      bizarroids_slider_engine.slider_slide_path @slide
    end
  end
end
