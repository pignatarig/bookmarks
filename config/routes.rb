Rails.application.routes.draw do
  get 'tags/create'

  get 'tags/destroy'

  resources :bookmarks
  get '/:unique_id', to: 'bookmarks#shortened', as: :shortened
  root to: 'bookmarks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
