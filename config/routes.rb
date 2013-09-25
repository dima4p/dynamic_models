DynamicModels::Application.routes.draw do

  get "static/risk_report"
  get "static/efficiency"

  resources :models, except: [:edit, :update]

  get 'proxies/:table_name', to: 'proxies#index', as: 'proxies'
  get 'proxies/:table_name/new', to: 'proxies#new', as: 'new_proxy'
  get 'proxies/:table_name/:id', to: 'proxies#show', as: 'proxy'
  get 'proxies/:table_name/:id/edit', to: 'proxies#edit', as: 'edit_proxy'
  post 'proxies/:table_name', to: 'proxies#create'
  post 'proxies/:table_name/update_column', to: 'proxies#update_column', as: 'update_column_proxies'
  put 'proxies/:table_name/:id', to: 'proxies#update'
  patch 'proxies/:table_name/:id', to: 'proxies#update'
  delete 'proxies/:table_name/:id', to: 'proxies#destroy'

  # You can have the root of your site routed with "root"
  root 'models#index'

end
