Rails.application.routes.draw do
  
  #~ resources :metaclasses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'hor#index'
  
  if true #~ routes: _navigation (nav_BarTOP)  ------------------------------------------
    get 'blocMetaclasses',      to: 'hor#blocMetaclasses'
    get 'changerEtatMetaclasse',to: 'hor#changerEtatMetaclasse'
    get 'deSelect',             to: 'hor#deSelect'
    
  end
 
 
  if true #~ routes: _nav_BarBOTTOM  ---------------------------------------
    get 'action',             to: 'hor#action' # action= repartir,valider,invalider,filtrer,variance,infoCeds,fixHor
    get 'parade',             to: 'hor#parade' # action= documents
  end    

end
