Rails.application.routes.draw do
  root "static_pages#home"

  scope "(:locale)", locale: /en|vi/ do
    get "users/new"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    get "users/new"
  end
end
