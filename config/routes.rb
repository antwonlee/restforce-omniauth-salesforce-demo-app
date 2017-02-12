Rails.application.routes.draw do
  root "homepages#show"
  devise_for :users
end
