TAccounts::Application.routes.draw do
  resources :worksheets do
    resources :accounts, :transactions
    member do
      get :trial_balance
    end
  end

  root :to => 'worksheets#index'
end
