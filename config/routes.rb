Rails.application.routes.draw do
  resources :contacts
  
  post 'check_emails' => "contacts#check_emails"
  post 'delete_all' => "contacts#delete_all"
  post 'download_all' => "contacts#download_all"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
