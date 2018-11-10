Rails.application.routes.draw do
  get 'get_processed_dataset', to: 'home#get_processed_dataset'

	root to: 'home#index'
end
