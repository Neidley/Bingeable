Rails.application.routes.draw do
  get 'tvshows/index'

  get 'tvshows/show'

  get 'tvshows/search'

  root 'tvshows#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
