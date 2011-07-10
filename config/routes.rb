TAccounts::Application.routes.draw do
  devise_for :users

  resources :worksheets do
    resources :accounts, :transactions
    member do
      get :trial_balance
    end
  end

  root :to => 'pages#index'
end
