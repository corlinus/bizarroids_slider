module Bizarroids::Slider
  class SlidesController < parent_controller.constantize
    respond_to :html
    before_action :set_collection, only: %i(index new create)
    before_action :set_slide, only: %i(edit update destroy up down)

    if Bizarroids::Slider.use_cancancan
      authorize_resource class: "Bizarroids::Slider::Slide", param_method: :slide_params
    end

    def index
      @slides = @collection.slides
    end

    def new
      @slide = @collection.slides.build
    end

    def create
      # remove media from params to hack carrierwave bug
      @slide = @collection.slides.build slide_params.except(:media)
      @slide.media = slide_params[:media]

      if @slide.save
        redirect_to_collection t('bizarroids.slide.slide_created')
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @slide.update slide_params
        redirect_to_collection t('bizarroids.slide.slide_updated')
      else
        render :edit
      end
    end

    def destroy
      @slide.destroy
      redirect_to_collection t('bizarroids.slide.slide_destroyed')
    end

    def up
      @slide.move_higher
      redirect_to_collection
    end

    def down
      @slide.move_lower
      redirect_to_collection
    end

    private

    def set_collection
      @collection = Collection.find_by! key: params[:collection_id]
    end

    def set_slide
      @slide = Slide.find params[:id]
      @collection = @slide.collection
    end

    def slide_params
      params.permit(bizarroids_slider_slide: @collection.slide_attributes)[:bizarroids_slider_slide]
    end

    def redirect_to_collection msg=''
      redirect_to bizarroids_slider_engine.slider_collection_slides_path(@collection), notice: msg
    end
  end
end
