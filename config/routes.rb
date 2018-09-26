Rails.application.routes.draw do
  get 'tvshows/index'

  get 'tvshows/show'

  root 'tvshows#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
