Rails.application.routes.draw do
  namespace :v1 do
    namespace :publishers do
      resources :shops, only: :index
    end

    namespace :shops do
      resources :book_sellings, only: :create
    end
  end
end
