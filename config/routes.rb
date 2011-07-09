TAccounts::Application.routes.draw do
  resources :worksheets
  root :to => 'worksheets#index'
end
