Bizarroids::Slider::Engine.routes.draw do
  scope module: :bizarroids do
    namespace :slider do
      resources :collections, only: :index, shallow: true do
        resources :slides, except: [:show] do
          patch :up, :down, on: :member
        end
      end
    end
  end
end
