Rails.application.routes.draw do

  mount Bizarroids::Slider::Engine => '/admin'
end
