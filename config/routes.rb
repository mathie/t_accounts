TAccounts::Application.routes.draw do
  resources :worksheets do
    resources :accounts
  end

  root :to => 'worksheets#index'
end
