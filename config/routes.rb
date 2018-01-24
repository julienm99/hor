Rails.application.routes.draw do
  
  
  resources :activites
  resources :metaclasses
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'hor#index'
  
  get 'valider',           to: 'hor#valider'
  get 'fixerHoraire',      to: 'hor#fixerHoraire'
  get 'choixMatiere',      to: 'hor#choixMatiere'
  get 'miseAjour',         to: 'hor#miseAjour'
  get 'deselectionner',    to: 'hor#deselectionner'
  get 'backbone',          to: 'hor#backbone'
  get 'nivS5',             to: 'hor#nivS5'
  get 'info',              to: 'hor#info'
  get 'metaclassesEPS',    to: 'hor#metaclassesEPS'
  
end
