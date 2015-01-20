Rails.application.routes.draw do
  
  post '/rate' => 'rater#create', :as => 'rate'
  resources :shops do
    resources :comments
    get 'page/:page', action: :index, on: :collection
  end


  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks"}

  root to: "shops#index"

end
  