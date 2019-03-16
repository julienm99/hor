Rails.application.routes.draw do
  
  
  #~ resources :activites
  #~ resources :metaclasses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'hor#index'
  
  if true #~ routes: TOP nav_bar  ------------------------------------------
    get 'blocMetaclasses',      to: 'hor#blocMetaclasses'
    get 'changerEtatMetaclasse',to: 'hor#changerEtatMetaclasse'
    get 'deSelect',             to: 'hor#deSelect'
    
    #~ get 'updateCedulables',   to: 'hor#updateCedulables'    
    #~ get 'contraintes',        to: 'hor#contraintes'
    
  end
 
 
  if true #~ routes: BOTTOM nav_bar  ---------------------------------------
    get 'action', to: 'hor#action' #action= repartir,valider,invalider,filtrer,variance,fixerCedulables,fixerHoraires
    
    get 'infoHoraire',        to: 'hor#infoHoraire'
    get 'infoCedulables',     to: 'hor#infoCedulables'
    
    #~ get 'repartir',           to: 'hor#repartir'    
    #~ get 'valider',            to: 'hor#valider'
    #~ get 'invalider',          to: 'hor#invalider'    
    #~ get 'filtrer',            to: 'hor#filtrer'
    #~ get 'variance',           to: 'hor#variance'
    #~ get 'fixerCedulables',    to: 'hor#fixerCedulables'
    #~ get 'fixerHoraire',       to: 'hor#fixerHoraire'
  end    

end
