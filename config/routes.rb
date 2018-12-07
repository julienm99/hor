Rails.application.routes.draw do
  
  
  resources :activites
  resources :metaclasses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'hor#index'
  
  if true #~ routes: TOP nav_bar  ------------------------------------------
    get 'blocMetaclasses',    to: 'hor#blocMetaclasses'
    
    get 'updateMetaclasses',  to: 'hor#updateMetaclasses'
    get 'updateCedulables',   to: 'hor#updateCedulables'
    get 'creerBaseDeDonnees', to: 'hor#creerBaseDeDonnees'
    
    get 'contraintes',        to: 'hor#contraintes'
    
    get 'deSelect',           to: 'hor#deSelect'
    
    get 'infoHoraire',        to: 'hor#infoHoraire'
    get 'infoCedulables',     to: 'hor#infoCedulables'
  end
  
  if true #~ routes: BOTTOM nav_bar  ---------------------------------------
    get 'repartir',          to: 'hor#repartir'
    get 'valider',           to: 'hor#valider'
    get 'invalider',         to: 'hor#invalider'
    get 'filtrer',           to: 'hor#filtrer'
    get 'variance',          to: 'hor#variance'
    get 'fixerCedulables',   to: 'hor#fixerCedulables'
    get 'fixerHoraire',      to: 'hor#fixerHoraire'
  end    

end
