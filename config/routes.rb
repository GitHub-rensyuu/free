Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 3.deviseが最初に来てない
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create,:destroy]
    resources :book_comments, only: [:create,:destroy]
  end

  resources :users, only: [:index,:show,:edit,:update]
  resources :groups do
    get "join" => "groups#join"
    delete "all_destroy" => 'groups#all_destroy'
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  get "search_book" => "books#search_book"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 1.endがない
end
