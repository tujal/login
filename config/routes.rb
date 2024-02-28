Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
   root "home#index"
   resources :users do
    resources :posts 
   end
end


