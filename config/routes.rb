TAccounts::Application.routes.draw do
  resources :worksheets do
    resources :accounts, :transactions
  end

  root :to => 'worksheets#index'
end
