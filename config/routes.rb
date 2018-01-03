Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'hor#index'
  
  get 'valider',      to: 'hor#valider'
  get 'fixerHoraire', to: 'hor#fixerHoraire'
  get 'choixMatiere', to: 'hor#choixMatiere'
  
  resources :metaclasses
  
  
end
