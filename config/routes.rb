Rails.application.routes.draw do

  root 'items#index'

  # devise_user_controller
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'signup'
  }

  resources :signup do
    collection do
      get 'user_info'
      get 'user_tel'
      get 'user_address'
      get 'user_card' # ここで、入力の全てが終了する
      get 'user_complete' # 登録完了後のページ
    end
  end

# resource "users", path: 'sign_up' , only: :registration do
#   collection do
#     get "registration", action: :show
#     get "done"
#   end
# end

  resources "users",only: :logout, path: '' do
    collection do
      get 'logout'
    end
  end

  resources "users",only: [:index,:profile,:card,:purchase], path: 'mypage' do
    collection do
      get 'profile'
      get 'card'
      get 'notifications'
      get 'todo'
      get 'purchase'
    end
  end
  
  
  patch 'mypage/profile/:id' => 'users#update', as: "mypage_profile"
  
  resources :users, only: [:listing, :in_progress, :completed], path: '/mypage/listings' do
    collection do
      get 'listing'
      get 'in_progress'
      get 'completed'
    end
  end
  

  resources :users, only: [:identification,:purchased], path: '/mypage' do
    collection do
      get 'identification'
      get 'purchased'
    end
  end 
  
  resource :users, action: :create_identification, only: :create_identification, path: '/mypage' do
    collection do
      post 'identification'
    end
  end

#   resources "users", path: "/u/:id", only: :show_profile do
#     collection do
#       get 'show_profile', path: ""
#     end
#   end
  
#   resources :cards, only: [:index, :new, :show] do
#     collection do
#       post 'show', to: 'cards#show'
#       post 'pay', to: 'cards#pay'
#       delete 'delete', to: 'cards#delete'
#     end
#   end
  
#   resource "products", path: "sell", only: :show, action: :new, as: "new_products"
#   resource "products", path: "sell", only: :create
#   resource "products", only: :edit, path: "/m:product_id"
#   resource "products", only: :destroy, path: "/m:product_id",as: "products_destroy"
#   resource "products", only: :update, path: "/m:product_id",as: "products_update"
  
#   resource :products,  only: :show_mine, path: "m:product_id" do
#     collection do
#       get 'show_mine'
#     end
#   end
  
#   resource :products, action: :search, path: "/search", only: :show, as: :search_products
  
#   resource "products", path: "/m:product_id", only: :show, as: :show_products do
#     resources "comments", only: :create
#     resources :cards, only: :buy do
#       collection do
#         post "buy", to: "cards#buy"
#       end
#     end
#   end

#   namespace :api do
#     resources "sell", controller: :products, only: :child, defaults: { format: 'json' } do
#       collection do
#         get 'child'
#       end
#     end
#     resources "sell", controller: :products, only: :grand_child, defaults: { format: 'json' } do
#       collection do
#         get 'grand_child'
#       end
#     end
#     resources "destroy", controller: :products, only: :image_destroy, defaults: { format: 'json' } do
#       collection do
#         delete "image_destroy"
#       end
#     end

#   end

#   resources "category", only: [:index, :show]
#   resources "brand", only: [:index, :show]
#   resources "areas", only: :show

end