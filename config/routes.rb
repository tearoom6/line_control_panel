Rails.application.routes.draw do
  root to: 'panel#index'
  get 'panel/index'
  post 'webhook/on_message'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
