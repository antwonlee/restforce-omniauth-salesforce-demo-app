Rails.application.routes.draw do
  root "homepages#show"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
  controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resource :accounts
end
