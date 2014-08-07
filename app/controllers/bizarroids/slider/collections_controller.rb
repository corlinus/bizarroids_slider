module Bizarroids::Slider
  class CollectionsController < parent_controller.constantize
    respond_to :html

    if Bizarroids::Slider.use_cancancan
      authorize_resource class: "Bizarroids::Slider::Collection", param_method: :permitted_params
    end

    def index
      @collections = Collection.actual
    end
  end
end
