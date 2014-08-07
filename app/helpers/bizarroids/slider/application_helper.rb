module Bizarroids::Slider
  module ApplicationHelper
    # TODO extract to gem
    def bizarroids_t key
      t key, scope: :bizarroids
    end

    # TODO extract to gem
    def bizarroids_edit_button path
      bizarroids_button path, :pencil
    end

    # TODO extract to gem
    def bizarroids_destroy_button path, confirm_message
      bizarroids_button path, :trash, method: :delete, data: { confirm: confirm_message }
    end

    # TODO extract to gem
    def bizarroids_manage_buttons edit_path, destroy_path, destroy_confirm_message
      safe_join [
        bizarroids_edit_button(edit_path),
        bizarroids_destroy_button(destroy_path, destroy_confirm_message)
      ]
    end

    # TODO extract to gem
    def bizarroids_move_buttons up_path, down_path
      safe_join [
        bizarroids_button(up_path, :'arrow-up', method: :patch),
        bizarroids_button(down_path, :'arrow-down', method: :patch)
      ]
    end

    def bizarroids_slider_menu_link
      link_to bizarroids_t('slider.name'),
        bizarroids_slider_engine.slider_collections_path,
        class: [bizarroids_slider_menu_link_class, 'list-group-item']
    end

    def bizarroids_slider_menu_link_class
      bizarroids_slider_menu_link_active? ? :active : nil
    end

    def bizarroids_slider_menu_link_active?
      controller.class.parent == Bizarroids::Slider
    end

    def bizarroids_slider_slides key
      Bizarroids::Slider[key]
    end

    def bizarroids_slider_each_slide key
      Bizarroids::Slider[key].each do |slide|
        yield slide
      end
    end

    private

    # TODO extract to gem
    def bizarroids_button path, icon, link_to_attrs={}
      link_to path, link_to_attrs, class: 'btn btn-link btn-xs text-primary' do
        content_tag :span, '', class: "glyphicon glyphicon-#{icon}"
      end
    end
  end
end
