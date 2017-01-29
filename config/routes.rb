Rails.application.routes.draw do
  root to: 'panel#index'

  get 'panel/index'
  get 'panel/talks/:talk_id', to: 'panel#talk', as: :panel_talk

  post 'webhook/on_message'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
